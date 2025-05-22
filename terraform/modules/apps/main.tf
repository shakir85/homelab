/**
 * Generic module for deploying Helm charts.
 * This documentation has two main sections: Values Injection Strategy and Usage.
 *
 * ## Value Injection Strategy
 *
 * This module supports two ways of injecting values into the Helm chart values and set_values.
 * The Terraform apply will not fail if you use only one of the value injection methods (values or set_values).
 * Both are optional and can be used independently or together.
 *
 * ### 1. `values` (YAML heredoc blocks)
 * Use the `values` variable to pass Helm values as one or more YAML-formatted strings.
 * This is equivalent to `-f values.yaml` in the Helm CLI.
 *
 * Example:
 * ```hcl
 * values = [
 *   <<-EOT
 *     replicaCount: 2
 *     image:
 *       tag: latest
 *   EOT
 * ]
 * ```
 *
 * Use this for complex, structured configurations such as nested maps, lists, or multi-line data.
 *
 * ### 2. `set_values` (Inline key=value)
 * Use the `set_values` variable to pass values via Helm's `--set` flag, where each value is a flat key-value pair.
 *
 * Example:
 * ```hcl
 * set_values = [
 *   { name = "replicaCount", value = "2" },
 *   { name = "image.tag", value = "latest" }
 * ]
 * ```
 *
 * This is suitable for simple overrides and dynamic injection of values.
 *
 * ## Usage
 *
 * Example of using the generic Helm release module to install a chart:
 *
 * ```hcl
 * module "nginx" {
 *   source  = "git::https://github.com/your-org/terraform-modules.git//helm-release?ref=<RELEASE_TAG>"
 *   name    = "nginx"
 *   namespace = "web"
 *
 *   repository     = "https://charts.bitnami.com/bitnami"
 *   chart          = "nginx"
 *   chart_version  = "15.0.0"
 *
 *   create_namespace = true
 *
 *   values = {
 *     service.type = "ClusterIP"
 *   }
 *
 *   values_file = "${path.module}/nginx-values.yaml"
 * }
 * ```
 */
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
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
