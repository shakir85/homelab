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
}

resource "helm_release" "prometheus_stack" {
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.0.0"
  values     = [
    file("${path.module}/values.yaml")
  ]

  dependency_update = true

  depends_on = [
    kubernetes_secret.grafana_admin_credentials
  ]
}
