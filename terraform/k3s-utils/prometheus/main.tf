# Requires a k8s secret for Grafana admin credentials. See the values.yaml file for more details.
# The secret should be created using kubectl or Terraform before applying this Helm release.
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
}
