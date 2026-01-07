# setup argocd github organization repository credential
# reference https://argo-cd.readthedocs.io/en/stable/operator-manual/argocd-repo-creds-yaml/
resource "kubernetes_secret" "github-app-credential" {
  metadata {
    name      = "github-app-credential"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    url                     = "https://github.com/ricardofukuda-org"
    type                    = "helm"
    githubAppID             = 2600587
    githubAppInstallationID = 102786917
  }

  binary_data = {
    githubAppPrivateKey = filebase64("${path.module}/secrets/github-app-argocd.pem")
  }

  type = "Opaque"
}
