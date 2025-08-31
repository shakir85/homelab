variable "namespace" {
  type        = string
  description = "Namespace where the cert-manager will be deployed"
}

variable "chart_version" {
  default     = "1.17.2"
  type        = string
  description = "Cert manager version"
}
