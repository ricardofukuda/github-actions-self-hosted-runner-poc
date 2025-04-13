resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "github-arc-systems"

    labels = {
      "istio-injection" = "enabled"
    }
  }
}

# Installing Actions Runner Controller
# To install the operator and the custom resource definitions (CRDs) in your cluster.
resource "helm_release" "github-arc" {
  name       = "github-arc"

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set-controller"
  version    = "0.11.0"

  namespace  = kubernetes_namespace.namespace.id

  values = [data.template_file.values-arc.rendered]

  depends_on = [  kubernetes_namespace.namespace ]
}