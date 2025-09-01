variable "kube_namespace" {
  type        = string
  default     = "metallb-system"
  description = "Namespace where MetlLb should be installed. Default to `metallb-system` (this is a standard MetalLb namespace, don't change for no reason.)"
}

variable "chart_version" {
  type        = string
  description = "MetalLB chart version"
}

variable "create_namespace" {
  type        = bool
  description = "Whether to create the namespace"
}
