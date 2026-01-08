locals {
  oidc_provider_url = data.aws_eks_cluster.eks.identity[0]["oidc"][0]["issuer"]
}

module "policy" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=v5.18.0"

  name        = lower("github-actions-runner-role")
  path        = "/"
  policy      = data.template_file.iam.rendered
}

#module "role" {
#  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v5.18.0"
#
#  create_role = true
#
#  role_name                     = lower("github-actions-runner-role")
#  provider_url                  = local.oidc_provider_url
#  oidc_fully_qualified_subjects = [lower("system:serviceaccount:github-arc-runners:github-arc-runner-set-gha-rs-no-permission")]
#  role_policy_arns              = [module.policy.arn]
#
#  tags = var.tags
#}

module "role" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v5.18.0"

  create_role = true

  role_name                     = lower("github-actions-runner-role")
  provider_url                  = aws_iam_openid_connect_provider.this.url
  oidc_subjects_with_wildcards = [lower("repo:ricardofukuda-org/github-actions-self-hosted-runner-workflow-test:*")] # the last ":*" allows any branch. If you setup environments, you should change as well.
  role_policy_arns              = [module.policy.arn]

  tags = var.tags
}

resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]
}

resource "aws_eks_access_entry" "access" { # Basically, it is going to make the aws role assume this k8s RBAC group inside k8s
  cluster_name      = data.aws_eks_cluster.eks.name
  principal_arn     = module.role.iam_role_arn
  kubernetes_groups = ["github-actions"]
  type              = "STANDARD"
}
