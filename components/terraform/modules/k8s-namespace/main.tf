terraform {
  required_version = "~> 1.13.1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}

resource "kubernetes_namespace" "this" {
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}
