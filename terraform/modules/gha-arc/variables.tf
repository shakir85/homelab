variable "kube_config_path" {
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
}

variable "kube_namespace" {
  description = "The name of the namespace where resource will be deployed"
  type        = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}

variable "github_app_private_key" {
  description = "Path to the GitHub App private key file"
  type        = string
}
