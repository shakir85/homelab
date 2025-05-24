/**
 * ## MetalLB Custom Resource Definitions (CRDs) Deployment
 *
 * This module installs the official MetalLB CRDs for Layer 2 advertisement with a static IP address pool using Terraform.
 *
 * ## Requirements
 * Set IP address ranges for MetalLB to allocate when a LoadBalancer Service is deployed;
 * ensure the range is available in your router - e.g., 192.168.50.90-192.168.50.99 may be reserved
 * for static mapping.
 *
 *
 * This will:
 * - Deploy a `IPAddressPool` CRD
 * - Deploy a `L2Advertisement` CRD that references the IP pool
 *
 * > Note: MetalLB must be up and running **before** running this configuration.
 */
resource "kubernetes_manifest" "ip_address_pool" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata = {
      name      = var.ipv4_address_pool_name
      namespace = var.kube_namespace
      labels    = var.shared_labels
    }
    spec = {
      addresses = var.ipv4_address_pool
    }
  }
}

resource "kubernetes_manifest" "l2_advertisement" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "L2Advertisement"
    metadata = {
      name      = "main-advertisement"
      namespace = var.kube_namespace
      labels    = var.shared_labels
    }
    spec = {
      ipAddressPools = [var.ipv4_address_pool_name]
    }
  }

  depends_on = [kubernetes_manifest.ip_address_pool]
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
