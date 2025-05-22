/**
 * Name of the Helm release
 */
variable "name" {
  type        = string
  description = "Name of the Helm release"
}

/**
 * Namespace to install the Helm release into
 */
variable "namespace" {
  type        = string
  description = "Kubernetes namespace to deploy the Helm release into"
}

/**
 * Helm chart name (e.g., bitnami/nginx)
 */
variable "chart" {
  type        = string
  description = "Helm chart name to install (e.g., bitnami/nginx)"
}

/**
 * Helm chart repository URL (e.g., https://charts.bitnami.com/bitnami).
 */
variable "repository" {
  type        = string
  description = "Helm repository URL to use"
}

/**
 * Chart version to install (e.g., 1.2.3). Optional
 */
variable "chart_version" {
  type        = string
  description = "Optional version of the Helm chart to install"
  default     = null
}

/**
 * Inline YAML values passed to the Helm release
 */
variable "values" {
  type        = list(string)
  description = "List of inline YAML values passed to the Helm chart"
  default     = []
}

/**
 * List of key-value Helm set values (each map should have "name" and "value").
 */
variable "set_values" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Optional list of Helm set values (key-value pairs)."
  default     = []
}

/**
 * Whether to wait until all resources are ready
 */
variable "wait" {
  type        = bool
  description = "Wait until all Helm chart resources are ready"
  default     = true
}

/**
 * Whether to create the namespace if it doesn't exist
 */
variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not already exist"
  default     = true
}
