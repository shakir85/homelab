variable "kube_config_path" {
  type        = string
  description = "Path to the kubeconfig file."
  default     = "~/.kube/config"
}

variable "namespace" {
  type        = string
  description = "K8s namespace in which the GitHub Actions Runner resources will be deployed."
  default     = "github-actions"
}

variable "github_token" {
  type        = string
  description = "PAT or GitHub App token with repo, workflow, and actions permissions."
  sensitive   = true
}
