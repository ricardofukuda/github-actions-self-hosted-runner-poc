data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name =  data.aws_eks_cluster.eks.name
}

data "template_file" "values" {
  template = file("config/values.yml")
  vars = {
    domain = var.route53_domain
    githubWebhookSecret = local.secrets.githubWebhookSecret
  }
}
