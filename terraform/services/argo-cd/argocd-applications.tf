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
  count    = 1

  depends_on = [kubernetes_namespace.qa, helm_release.argocd]
}
