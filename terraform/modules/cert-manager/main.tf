resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.namespace
  version    = var.chart_version

  set = [{
    name  = "prometheus.enabled"
    value = "false"
    },
    {
      name  = "crds.enabled"
      value = "true"
    },
    {
      name  = "crds.keep"
      value = "false"
  }]

  values = [
    yamlencode({
      global = {
        commonLabels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      }
    })
  ]
}
