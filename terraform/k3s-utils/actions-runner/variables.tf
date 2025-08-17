variable "kube_config_path" {
  default     = "~/.kube/config"
  type        = string
  description = "Path to kubeconfig file relative to where this script will run"
}

variable "kube_context" {
  description = "The name of the kubeconfig context to use"
  type        = string
  default     = "k3s-utils-ctx"
}

variable "gha_runners" {
  type = map(object({
    gha_runner_release_name    = string
    repo_values_file   = string
  }))
  description = "Map of GHA runners to deploy per repository"
}
