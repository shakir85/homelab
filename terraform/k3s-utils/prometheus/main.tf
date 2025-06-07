resource "kubernetes_secret" "grafana_admin_credentials" {
  metadata {
    name      = "grafana-admin-credentials"
    namespace = "monitoring"
  }

  data = {
    admin-user     = filebase64("./admin")
    admin-password = filebase64("./admin-login")
  }

  type = "Opaque"

  depends_on = [ module.monitoring_namespace ]
}

resource "helm_release" "prometheus_stack" {
  name       = "prometheus"
  namespace  = "monitoring"
  chart      = "../../../helm/charts/kube-prometheus-stack"
  version    = "73.2.0"
  values     = [
    file("${path.module}/values.yaml")
  ]

  dependency_update = true

  depends_on = [
    module.monitoring_namespace,
    kubernetes_secret.grafana_admin_credentials
  ]
}
