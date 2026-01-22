resource "aws_route53_zone" "private" {
  name          = var.route53_domain
  force_destroy = true

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
