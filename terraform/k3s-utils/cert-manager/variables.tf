variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_namespace" {
  default     = "cert-manager"
  type        = string
  description = "Namespace where the cert-manager will be deployed"
}

variable "cert_manager_version" {
  default     = "1.17.2"
  type        = string
  description = "Cert manager version"
}
