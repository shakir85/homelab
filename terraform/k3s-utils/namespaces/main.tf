module "actions_namespace" {
  source = "../../modules/namespace"
  name   = "actions"
  labels = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

module "monitoring_namespace" {
  source = "../../modules/namespace"
  name   = "monitoring"
  labels = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
