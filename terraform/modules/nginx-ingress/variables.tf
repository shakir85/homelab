variable "name" {
  description = "The name of the Helm release"
  type        = string
  default     = "nginx-ingress"
}

variable "namespace" {
  description = "The namespace in which to install the ingress controller"
  type        = string
  default     = "ingress-nginx"
}

variable "chart_version" {
  description = "The version of the ingress-nginx Helm chart to install"
  type        = string
  default     = "4.10.0"
}

variable "repository" {
  description = "The Helm chart repository URL"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}
