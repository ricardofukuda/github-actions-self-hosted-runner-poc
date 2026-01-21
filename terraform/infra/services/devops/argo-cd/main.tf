resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "argocd"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "helm_release" "argocd" {
  name = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = kubernetes_namespace.namespace.id
  version   = "8.5.3"

  values = [data.template_file.values.rendered]

  depends_on = [kubernetes_namespace.namespace]
}
