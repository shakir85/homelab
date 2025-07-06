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

# Expose Promtail Syslog Receiver as a LoadBalancer service
resource "kubernetes_service" "promtail_syslog" {
  metadata {
    name      = "promtail-syslog"
    namespace = "monitoring"

    labels = {
      app = "promtail"
      component = "syslog-receiver"
    }

    annotations = {
      "metallb.universe.tf/address-pool" = "default-pool"
    }
  }

  spec {
    selector = {
      syslog-receiver = "true"
    }
    # MetalLb should assign a stable IP from the default-pool
    type = "LoadBalancer"

    port {
      name        = "syslog"
      port        = 1514
      target_port = 1514
      protocol    = "TCP"
    }
  }
}
