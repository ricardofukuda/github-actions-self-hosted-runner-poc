data "aws_caller_identity" "current" {}

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
    domain       = var.domain
    github_org   = local.secrets.github_org_url
  }
}

data "template_file" "iam" {
  template = file("${path.module}/policies/iam.json")
  vars = {
    s3_bucket_state_arn = aws_s3_bucket.state.arn
  }
}

data "template_file" "bucket-policy" {
  template = file("${path.module}/policies/bucket-policy.json")
  vars = {
    s3_bucket_state_arn = aws_s3_bucket.state.arn
    account_id          = local.account_id
  }
}
