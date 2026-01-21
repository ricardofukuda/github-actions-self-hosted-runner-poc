locals {
  oidc_provider_url = data.aws_eks_cluster.eks.identity[0]["oidc"][0]["issuer"]
}

module "policy" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=v5.18.0"

  name   = lower("external-dns-${data.aws_eks_cluster.eks.name}")
  path   = "/"
  policy = data.template_file.iam.rendered
}

module "role" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v5.18.0"

  create_role = true

  role_name                     = lower("external-dns-${data.aws_eks_cluster.eks.name}")
  provider_url                  = local.oidc_provider_url
  oidc_fully_qualified_subjects = [lower("system:serviceaccount:external-dns:external-dns")]
  role_policy_arns              = [module.policy.arn]
}
