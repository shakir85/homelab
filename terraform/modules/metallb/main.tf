/**
 * ## MetalLB Helm Deployment
 *
 * This module installs the official [MetalLB Helm chart](https://metallb.universe.tf/installation/#installation-with-helm)
 *
 * ## Usage
 *
 * ```hcl
 * module "metallb" {
 *   source  = "path/to/this/module"
 * }
 * ```
 *
 * This will:
 * - Install the MetalLB Helm chart version specified in `var.metallb_version` in the `metallb-system` namespace
 *
 * > Note: If you plan to install MetalLB Custom Resource Definition (CRDs) for IP advertisement, they must be created **after** the Helm chart installation.
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

resource "helm_release" "metallb" {
  name       = var.release_name
  namespace  = var.kube_namespace
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = var.metallb_version

  create_namespace = true

  values = [
    yamlencode({
      configInline = {} # Empty to disable legacy config
    })
  ]
}
