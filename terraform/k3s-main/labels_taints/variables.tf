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

variable "size_label_key" {
  description = "The key for the size label"
  type        = string
  default     = "k3s.shakir.cloud/size"
}

variable "name_label_key" {
  description = "The key for the name label"
  type        = string
  default     = "k3s.shakir.cloud/name"
}
