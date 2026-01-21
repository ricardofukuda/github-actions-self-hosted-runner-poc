resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "website"
  type    = "CNAME"
  ttl     = 300
  records = [var.cloudfront_distribution_domain]
}

data "aws_route53_zone" "public" {
  name         = var.domain
  private_zone = false
}
