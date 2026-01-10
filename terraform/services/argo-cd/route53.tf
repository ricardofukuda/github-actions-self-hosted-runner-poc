data "aws_route53_zone" "public" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "www_public" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "argo"
  type    = "CNAME"
  ttl     = 300
  records = [ data.kubernetes_service.istio_service_public.status.0.load_balancer.0.ingress.0.hostname ]
}