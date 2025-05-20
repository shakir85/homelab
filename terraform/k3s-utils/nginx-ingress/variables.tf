variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_namespace" {
  default     = "ingress"
  type        = string
  description = "Namespace where the ingress controller will be deployed"
}
