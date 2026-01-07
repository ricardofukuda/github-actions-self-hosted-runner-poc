# Reference https://argo-cd.readthedocs.io/en/latest/user-guide/application-specification/

#resource "kubernetes_manifest" "guestbook" {
#  manifest = yamldecode(file("${path.module}/applications/guestbook.yaml"))
#}

#Setup an argocd application to load all the argocd's applications
resource "kubernetes_manifest" "applications" {
  manifest = yamldecode(file("${path.module}/applications/applications.yaml"))
  count    = 1

  depends_on = [helm_release.argocd]
}

#resource "kubernetes_manifest" "applications-set" {
#  manifest = yamldecode(file("${path.module}/applications/application-set.yaml"))
#}

