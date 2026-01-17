resource "aws_route53_zone" "private" {
  name          = var.domain
  force_destroy = true

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = var.tags
}
