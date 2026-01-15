data "aws_region" "current" {}

data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks.name
}

data "template_file" "values" {
  template = file("${path.module}/config/values.yaml")

  vars = {
    iam_role_arn = module.role.iam_role_arn
    cluster_name = data.aws_eks_cluster.eks.name
    region       = data.aws_eks_cluster.eks.region
    domain       = data.aws_route53_zone.public.name
  }
}

data "template_file" "iam" {
  template = file("${path.module}/polices/iam.json")
  vars = {
    hosted_zone_arn = data.aws_route53_zone.public.arn
  }
}

data "aws_route53_zone" "public" {
  name         = var.domain
  private_zone = false
}
