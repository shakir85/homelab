module "metallb" {
  source          = "../../modules/metallb"
  release_name    = "metallb"
  metallb_version = "0.14.5"
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
