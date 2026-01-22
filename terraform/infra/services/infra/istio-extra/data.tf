data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks.name
}

data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

data "kubernetes_service" "istio_service_public" {
  metadata {
    name      = "istio-ingressgateway-public"
    namespace = "istio-system"
  }
}

data "aws_elb" "public" {
  name = local.public_elb_id
}
