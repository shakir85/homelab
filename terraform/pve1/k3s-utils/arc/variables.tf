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

variable "repository" {
  type = string
  description = "Repository where the controller will be connected to in `<org>/<repo>` format."
  default = "shakir85/homelab"
}

variable "gha_controller_name" {
  type = string
  description = "Name of the GHA runners Controller."
  default = "gha-runner-controller"
}

variable "gha_scale_set_name" {
  type = string
  description = "Name of the GHA runners Controller."
  default = "gha-runner-scale-set"
}

variable "runner_labels" {
  type = string
  description = "Comma separated labels for runners"
  default = "self-hosted,linux,containerd"
}
