variable "service_account_name" {
  description = "The name of the ServiceAccount in the CI/CD namespace"
  type        = string
}

variable "service_account_namespace" {
  description = "Namespace where the ServiceAccount resides"
  type        = string
}

variable "namespace" {
  description = "Namespace where the Helm deployment will be performed"
  type        = string
}

variable "role_name" {
  description = "Name of the Role to create in the target namespace"
  type        = string
}

variable "shared_labels" {
  description = "Shared labels"
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}
