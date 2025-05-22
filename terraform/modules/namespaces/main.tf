/**
 * ## Usage
 *
 * This is an example of how to use this module to provision a namespace with optional labels and annotations.
 *
 * ```hcl
 * module "example_namespace" {
 *   source = "path/to/this/module"
 *
 *   # Required
 *   name = "example"
 *
 *   # Optional
 *   labels = {
 *     "env" = "dev"
 *   }
 *
 *   annotations = {
 *     "owner" = "dev-team"
 *   }
 * }
 * ```
 */
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
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
