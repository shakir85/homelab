variable "kube_config" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
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

variable "runner_name" {
  description = "Name of the GitHub Actions runner"
  type        = string
}
