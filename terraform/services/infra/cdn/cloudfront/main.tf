locals {
  public_elb_domain    = data.kubernetes_service.istio_service_public.status.0.load_balancer.0.ingress.0.hostname
  public_elb_origin_id = "${data.aws_eks_cluster.eks.name}-public-elb"
  public_elb_id        = regex("(.+)-(.+).us-east-1.elb.amazonaws.com", local.public_elb_domain)[0]
}

data "aws_elb" "public" {
  name = local.public_elb_id
}

resource "aws_cloudfront_distribution" "main" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  aliases         = ["website.${var.domain}", "argo.${var.domain}"]

  origin {
    domain_name = local.public_elb_domain
    origin_id   = local.public_elb_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.certificate.arn
    cloudfront_default_certificate = true
    ssl_support_method             = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.public_elb_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 3600
  }

  tags = {
    "lb" = "main"
  }
}

resource "aws_security_group_rule" "elb_allow_cloudfront" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  security_group_id = data.aws_elb.public.source_security_group_id
}

