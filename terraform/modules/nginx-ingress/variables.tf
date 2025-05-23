variable "release_name" {
  description = "The name of the Helm release"
  type        = string
}

variable "namespace" {
  description = "The namespace where the ingress controller will be deployed"
  type        = string
}

variable "chart_version" {
  description = "The version of the ingress-nginx Helm chart to install"
  type        = string
  default     = "4.10.0"
}

variable "ingress_controller_name" {
  description = "A name for the ingress controller. It sets the values of `controller.ingressClass` and `controller.ingressClassResource.name`. This is essential because the K8s ingress-resources's `ingressClassName` attribute  will use this value"
  type        = string
  default     = "nginx"
}
