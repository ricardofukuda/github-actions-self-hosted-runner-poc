locals {
  oidc_provider_url = data.aws_eks_cluster.eks.identity[0]["oidc"][0]["issuer"]
}

module "policy" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=v5.18.0"

  name   = lower("${var.project_name}-${var.env}")
  path   = "/"
  policy = data.template_file.iam.rendered
}

module "role" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v5.18.0"

  create_role = true

  role_name                     = lower("${var.project_name}-${var.env}")
  provider_url                  = local.oidc_provider_url
  oidc_fully_qualified_subjects = [lower("system:serviceaccount:${var.env}:${var.project_name}")]
  role_policy_arns              = [module.policy.arn]
}
