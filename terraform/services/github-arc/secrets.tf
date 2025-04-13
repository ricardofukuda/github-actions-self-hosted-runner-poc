resource "kubernetes_secret" "github-app-secret" {
  metadata {
    name = "pre-defined-secret" # Somehow, this name is hardcoded inside the helm chart therefore it is not possible to change it
    namespace = "github-arc-runners"
  }

  data = {
    github_app_id=local.secrets.github_app_id
    github_app_installation_id=local.secrets.github_app_installation_id
  }

  binary_data = {
    github_app_private_key = filebase64("${path.module}/secrets/github-app-pk.pem")
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.namespace-arc-runner-set ]
}