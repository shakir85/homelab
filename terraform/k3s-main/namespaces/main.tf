module "apps_namespace" {
  source = "../../modules/namespaces"
  name   = "apps"
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}

