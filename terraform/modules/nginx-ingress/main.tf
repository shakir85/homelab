terraform {
  required_version = "~> 1.5.7"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
  }
}

resource "helm_release" "nginx_ingress" {
  name             = var.release_name
  namespace        = var.namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.chart_version
  create_namespace = true

  values = [
    yamlencode({
      controller = {
        kind = "DaemonSet"
        ingressClassResource = {
          name            = var.ingress_controller_name
          enabled         = true
          controllerValue = "k8s.io/ingress-nginx"
        }
        ingressClass       = var.ingress_controller_name
        ingressClassByName = true
        service = {
          type = "LoadBalancer"
          port = {
            http = 80
          }
        }
        fullnameOverride = "nginx-controller"
      }
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      commonLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    })
  ]
}
