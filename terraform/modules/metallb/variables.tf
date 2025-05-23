variable "release_name" {
  type        = string
  default     = "metallb"
  description = "Helm release name"
}

variable "kube_namespace" {
  type        = string
  default     = "metallb-system"
  description = "Namespace where MetlLb should be installed. Default to `metallb-system` (this is a standard MetalLb namespace, don't change if you don't know what you're doing!)"
}

variable "metallb_version" {
  type        = string
  default     = "0.14.5"
  description = "MetlLb version"
}
