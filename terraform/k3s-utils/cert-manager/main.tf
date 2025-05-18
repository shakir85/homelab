resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.kube_namespace
  create_namespace = true
  version    = var.version

  set {
    name  = "prometheus.enabled"
    value = "false"
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file"
  default     = var.kube_config_path
}
