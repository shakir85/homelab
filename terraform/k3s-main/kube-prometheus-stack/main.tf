# Requires a k8s secret for Grafana admin credentials. See the values.yaml file for more details.
# The secret should be created using kubectl or Terraform before applying this Helm release.
resource "helm_release" "prometheus_stack" {
  name       = var.kube_namespace
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.0.0"
  values = [
    file("${path.module}/values.yaml")
  ]

  dependency_update = true
}

resource "helm_release" "loki_stack" {
  name       = "loki"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.10.2"
  values = [
    file("${path.module}/loki-values.yaml")
  ]

  dependency_update = true
  depends_on        = [helm_release.prometheus_stack]
}
