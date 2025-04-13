data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name =  data.aws_eks_cluster.eks.name
}

data "template_file" "values-arc" {
  template = file("config/values-arc.yml")
}

data "template_file" "values-runner-set" {
  template = file("config/values-runner-set.yml")
}
