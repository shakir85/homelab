terraform {
  required_version = "~> 1.5.7"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
  }
}
resource "helm_release" "this" {
  name             = var.name
  namespace        = var.namespace
  repository       = var.repository
  chart            = var.chart
  version          = var.chart_version
  wait             = var.wait
  create_namespace = var.create_namespace

  # Inline values passed as YAML string list (see comment above or README.md)
  values = var.values

  # Inline key=value Helm set values (see comment above or README.md)
  dynamic "set" {
    for_each = var.set_values
    content {
      name  = set.value.name
      value = set.value.value
    }
  }
}
