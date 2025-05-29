module "cert_manager_namespace" {
  source = "../../modules/namespace"
  name   = var.kube_namespace
  labels = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.kube_namespace
  version    = var.cert_manager_version

  set {
    name  = "prometheus.enabled"
    value = "false"
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
  values = [
    yamlencode({
      global = {
        commonLabels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      }
    })
  ]
  depends_on = [module.cert_manager_namespace]
}
