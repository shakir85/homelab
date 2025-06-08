variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
  default     = "k3s-main-ctx"
}

variable "kube_namespace" {
  default     = "monitoring"
  type        = string
  description = "Namespace where the monitoring stack will be deployed"
}
