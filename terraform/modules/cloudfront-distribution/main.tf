data "kubernetes_service" "istio_service_public" {
  metadata {
    name      = "istio-ingressgateway-public"
    namespace = "istio-system"
  }
}

data "aws_acm_certificate" "certificate" {
  domain      = var.route53_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "public" {
  name         = var.route53_domain
  private_zone = false
}

locals {
  public_elb_domain = data.kubernetes_service.istio_service_public.status.0.load_balancer.0.ingress.0.hostname
}

resource "aws_cloudfront_distribution" "main" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  aliases         = [for k, v in var.route53_records : "${v}.${var.route53_domain}"]

  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = local.public_elb_domain
      origin_id   = origin.value.origin_id

      custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.certificate.arn
    cloudfront_default_certificate = false
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  default_cache_behavior { # ". If you create additional cache behaviors, the default cache behavior is always the last to be processed. Other cache behaviors are processed in the order in which they're listed in the CloudFront console"
    allowed_methods  = var.default_cache_behavior.allowed_methods
    cached_methods   = var.default_cache_behavior.cached_methods
    target_origin_id = var.default_cache_behavior.target_origin_id

    forwarded_values {
      query_string = var.default_cache_behavior.forwarded_values.query_string
      headers      = var.default_cache_behavior.forwarded_values.headers # "*" implicitely it is a no-cache because forward all requests to the Origin
      cookies {
        forward = var.default_cache_behavior.forwarded_values.cookies.forward
      }
    }

    viewer_protocol_policy = var.default_cache_behavior.viewer_protocol_policy
    min_ttl                = var.default_cache_behavior.min_ttl
    default_ttl            = var.default_cache_behavior.default_ttl
    max_ttl                = var.default_cache_behavior.max_ttl
  }

  tags = {
    "Name" = "${one(var.route53_records)}.${var.route53_domain}"
  }
}

resource "aws_route53_record" "record" {
  for_each = var.route53_records

  zone_id = data.aws_route53_zone.public.zone_id
  name    = each.key
  type    = "CNAME"
  ttl     = 300

  records = [aws_cloudfront_distribution.main.domain_name]
}
