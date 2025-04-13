resource "kubernetes_namespace" "namespace-arc-runner-set" {
  metadata {
    name = "github-arc-runners"

    labels = {
      "istio-injection" = "enabled"
    }
  }
}

# Configuring Actions Runner Scale Set
resource "helm_release" "github-arc-runner-set" {
  name       = "github-arc-runner-set"

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"

  namespace  = kubernetes_namespace.namespace-arc-runner-set.id

  values = [data.template_file.values-runner-set.rendered]
  
  set {
    name = "githubConfigSecret"
    value =  "pre-defined-secret"
  }

  set {
    name = "githubConfigUrl"
    value =  local.secrets.github_org_url
  }

  depends_on = [ helm_release.github-arc, kubernetes_namespace.namespace-arc-runner-set ]
}