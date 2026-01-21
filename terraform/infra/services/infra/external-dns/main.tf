resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external-dns" {
  name = "external-dns"

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.19.0"

  namespace = kubernetes_namespace.namespace.id

  values = [data.template_file.values.rendered]

  depends_on = [kubernetes_namespace.namespace]
}
