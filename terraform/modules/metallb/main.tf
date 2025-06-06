terraform {
  required_version = ">= 1.5.7"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
}

resource "helm_release" "metallb" {
  name       = var.release_name
  namespace  = var.kube_namespace
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = var.metallb_version

  create_namespace = true

  values = [
    yamlencode({
      configInline = {}, # Empty to disable legacy config
      controller = {
        labels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      },
      speaker = {
        labels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      },
    })
  ]
}
