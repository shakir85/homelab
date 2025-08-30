variable "gha_runners" {
  type = map(object({
    gha_runner_release_name = string
    repo_values_file        = string
  }))
  description = "Map of GHA runners to deploy per repository"
}

variable "create_namespace" {
  description = "Whether to create the namespace for the GHA runners"
  type        = bool
  default     = false
}

variable "namespace" {
  description = "The namespace to deploy the GHA runners into"
  type        = string
  default     = "actions"
}
