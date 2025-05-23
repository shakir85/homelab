/**
 * ## MetalLB Helm Deployment
 *
 * This module installs the official [MetalLB Helm chart](https://metallb.universe.tf/installation/#installation-with-helm)
 * and configures a simple Layer 2 advertisement with a static IP address pool using Terraform.
 *
 * ## Requirements
 * Set IP address ranges for MetalLB to allocate from when a LoadBalancer Service is deployed;
 * ensure the range is available in your router - e.g., 192.168.50.90-192.168.50.99 may be reserved
 * for static mapping.
 *
 * ## Usage
 *
 * ```hcl
 * module "metallb" {
 *   source  = "path/to/this/module"
 *   # Required variables
 *   metallb_chart_version = "0.14.5"
 *   ip_range              = ["10.10.50.90-10.10.50.99"]
 *   pool_name             = "first-pool"
 *   advertisement_name    = "main-advertisement"
 * }
 * ```
 *
 * This will:
 * - Install the MetalLB Helm chart in the `metallb-system` namespace
 * - Deploy a `IPAddressPool` CRD
 * - Deploy a `L2Advertisement` CRD that references the IP pool
 *
 * > Note: MetalLB CRDs must be created **after** the Helm chart installation, so this configuration
 * includes appropriate `depends_on` logic to ensure ordering.
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
