resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "external-secrets"
  }
}

resource "helm_release" "external-secrets" {
  name = "external-secrets"

  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "1.2.0"

  namespace = kubernetes_namespace.namespace.id

  values = [data.template_file.values.rendered]

  depends_on = [kubernetes_namespace.namespace]
}
