module "ingress_ns" {
  source = "../../modules/namespace"
  name   = "ingress-nginx"
  labels = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

module "nginx_ingress_controller" {
  source        = "../../modules/nginx-ingress"
  release_name  = "default"
  namespace     = "ingress-nginx"
  chart_version = "4.10.0"
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
