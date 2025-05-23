variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
  default     = "k3s-main-ctx"
}

variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_namespace" {
  type        = string
  default     = "cicd"
  description = "Namespace where the gha-runner service account will reside (typically 'cicd')"
}

variable "k3s_main_control_plane_ipv4" {
  type        = string
  description = "Control plane IP or DNS"
}
