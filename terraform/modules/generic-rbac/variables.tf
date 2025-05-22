variable "namespace" {
  type        = string
  description = "Namespace for the Role and Binding"
}

variable "role_name" {
  type        = string
  description = "Name of the Kubernetes Role"
}

variable "service_account_name" {
  type        = string
  description = "Name of the service account to bind the Role to"
}

variable "rules" {
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
  description = "List of RBAC rules"
}
