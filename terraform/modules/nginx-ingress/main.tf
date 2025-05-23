/**
 * Terraform Module: nginx-ingress
 *
 * Installs the NGINX Ingress Controller using the official Helm chart.
 *
 * This module:
 * - Installs the controller as a DaemonSet.
 * - Removes the `controller.service.port.https` value from values.yaml. TLS is terminated outside the ingress.
 *
 * Usage:
 *
 * module "nginx_ingress" {
 *   source  = "./nginx-ingress"
 *   name    = "nginx-ingress"
 *   namespace = "ingress-nginx"
 *   chart_version = "4.10.0"
 *   repository    = "https://kubernetes.github.io/ingress-nginx"
 * }
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

resource "helm_release" "nginx_ingress" {
  name             = var.name
  namespace        = var.namespace
  repository       = var.repository
  chart            = "ingress-nginx"
  version          = var.chart_version
  create_namespace = true

  values = [
    yamlencode({
      controller = {
        kind = "DaemonSet"
        service = {
          # Intentionally disabling `port.https` values
          # TLS is terminated outside the ingress.
          type = "ClusterIP"
          port = {
            http = 80
          }
        }
      }
    })
  ]
}
