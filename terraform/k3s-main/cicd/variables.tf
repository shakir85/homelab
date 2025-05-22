variable "cluster_context" {
  description = "Kubeconfig context for the target cluster"
  type        = string
}

variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_namespace" {
  default     = "cicd"
  type        = string
  description = "Namespace where the resources will be deployed"
}

variable "control_plane_ipv4" {
  type        = string
  description = "IPv4 of the target Control Plane."
}
