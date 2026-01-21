resource "kubernetes_secret" "atlantis-secrets" {
  metadata {
    name      = "atlantis-secrets"
    namespace = kubernetes_namespace.namespace.id
  }

  data = {
    github_app_id              = local.secrets.github_app_id
    github_app_installation_id = local.secrets.github_app_installation_id
    webhook_secret             = local.secrets.webhook_secret
    username                   = local.secrets.username
    password                   = local.secrets.password
  }

  binary_data = {
    github_app_private_key = filebase64("${path.module}/secrets/atlantis-github-app-pk.pem")
  }

  type = "Opaque"
}
