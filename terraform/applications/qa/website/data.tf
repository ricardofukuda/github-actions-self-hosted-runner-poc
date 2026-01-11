data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_eks_cluster" "eks" {
  name = "eks-infra"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks.name
}

data "template_file" "iam" {
  template = file("${path.module}/policies/iam.json")
  vars = {
    resource_arn = lower("arn:aws:secretsmanager:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:secret:${data.aws_eks_cluster.eks.name}/${var.env}/${var.tags.App}-*")
  }
}
