resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "atlantis"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "helm_release" "atlantis" {
  name = "atlantis"

  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"

  namespace = kubernetes_namespace.namespace.id

  values = [data.template_file.values.rendered]

  version = "5.25.0"

  depends_on = [kubernetes_namespace.namespace]
}
