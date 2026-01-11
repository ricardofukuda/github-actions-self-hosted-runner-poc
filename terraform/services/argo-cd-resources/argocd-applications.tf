data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks.name
}

resource "kubernetes_namespace" "qa" {
  metadata {
    name = "qa"
    labels = {
      istio-injection = "enabled"
    }
  }
}

#Setup an argocd application to load all the argocd's applications
resource "kubernetes_manifest" "applications" {
  manifest = yamldecode(file("${path.module}/applications/applications-qa.yaml"))

  depends_on = [kubernetes_namespace.qa]
}
