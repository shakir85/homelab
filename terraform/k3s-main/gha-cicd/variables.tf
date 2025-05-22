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
  type        = string
  default     = "cicd"
  description = "Namespace where the gha-runner service account will reside (typically 'cicd')"
}

variable "control_plane_ipv4" {
  type        = string
  description = "Control plane IP or DNS"
}

variable "secre_role_ns" {
  type        = string
  description = "Namespace for the role from which they'll access tokens"
  default     = "foo"
}
