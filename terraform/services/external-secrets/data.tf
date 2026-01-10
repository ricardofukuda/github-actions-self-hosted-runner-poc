data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks.name
}

data "template_file" "values" {
  template = file("config/values.yaml")

  vars = {
    iam_role = module.role.iam_role_arn
  }
}

data "template_file" "cluster-secret-stores" {
  template = file("${path.module}/manifests/cluster-secret-stores.yaml")

  vars = {
    region = data.aws_region.current.name
  }
}

data "template_file" "iam" {
  template = file("${path.module}/polices/iam.json")
  vars = {
    resource_arn = "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${data.aws_eks_cluster.eks.name}/*"
  }
}
