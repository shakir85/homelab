variable "config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
}

variable "config_context" {
  description = "Kubernetes context to use"
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

variable "name" {
  description = "Name of the GitHub Actions runner"
  type        = string
}

variable "repo" {
  description = "GitHub repository where the runner will be linked with"
  type        = string
}

variable "org" {
  description = "GitHub organization for the repository"
  type        = string
}

variable "rbac_namespaces" {
  description = "List of namespaces to which the GitHub Actions runner will have RBAC access"
  type        = list(string)
}

variable "metallb_namespace" {
  description = "Kubernetes namespace for MetalLB"
  type        = string
}
