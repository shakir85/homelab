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

variable "chart_version" {
  description = "Helm chart version for csi-driver-nfs"
  type        = string
  default     = "4.11.0"
}
