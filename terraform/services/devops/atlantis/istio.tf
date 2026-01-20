resource "kubernetes_manifest" "istio_gateway_public" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "atlantis"
      "namespace" = "atlantis"
    }
    "spec" = {
      "selector" = {
        "istio" = "ingressgateway-public"
      }
      "servers" = [
        {
          "hosts" = [
            "atlantis.${var.domain}",
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
            "atlantis.${var.domain}",
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

  depends_on = [kubernetes_namespace.namespace]
}

resource "kubernetes_manifest" "istio_virtual_service_public" {
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = "atlantis"
      "namespace" = "atlantis"
    }
    "spec" = {
      "gateways" = [
        "atlantis"
      ]
      "hosts" = [
        "atlantis.${var.domain}",
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
                "host" = "atlantis"
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

  depends_on = [kubernetes_manifest.istio_gateway_public, kubernetes_namespace.namespace]
}
