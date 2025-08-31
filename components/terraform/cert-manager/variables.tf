variable "kube_config_path" {
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
}

variable "namespace" {
  type        = string
  description = "Namespace where the cert-manager will be deployed"
}
