resource "kubernetes_manifest" "istio_gateway" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "argocd"
      "namespace" = "argocd"
    }
    "spec" = {
      "selector" = {
        "istio" = "ingressgateway"
      }
      "servers" = [
        {
          "hosts" = [
            "argo.${var.domain}",
          ]
          "port" = {
            "name"     = "http"
            "number"   = 80
            "protocol" = "HTTP"
          }
          "tls" = {
            "httpsRedirect" = true
          }
        },
        {
          "hosts" = [
            "argo.${var.domain}",
          ]
          "port" = {
            "name"     = "https"
            "number"   = 443
            "protocol" = "HTTP"
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "istio_virtual_service" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = "argocd"
      "namespace" = "argocd"
    }
    "spec" = {
      "gateways" = [
        "argocd"
      ]
      "hosts" = [
        "argo.${var.domain}",
      ]
      "http" = [
        {
          "match" = [
            {
              "uri" = {
                "prefix" = "/"
              }
            },
          ]
          "route" = [
            {
              "destination" = {
                "host" = "argo-cd-argocd-server"
                "port" = {
                  "number" = 80
                }
              }
            },
          ]
        },
      ]
    }
  }
}