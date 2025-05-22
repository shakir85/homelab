variable "gha_service_account_name" {
  description = "The name of the ServiceAccount in the CI/CD namespace"
  type        = string
}

variable "gha_service_account_namespace" {
  description = "Namespace where the CI/CD ServiceAccount resides"
  type        = string
}

variable "target_namespace" {
  description = "Namespace where the Helm deployment will be performed"
  type        = string
}

variable "role_name" {
  description = "Name of the Role to create in the target namespace"
  type        = string
  default     = "gha-helm-deployer"
}
