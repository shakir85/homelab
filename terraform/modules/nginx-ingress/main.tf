resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  namespace        = var.kube_namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.chart_version
  create_namespace = var.create_namespace

  values = [
    yamlencode({
      controller = {
        kind = "DaemonSet"
        ingressClassResource = {
          name            = var.ingress_controller_name
          enabled         = true
          controllerValue = "k8s.io/ingress-nginx"
        }
        ingressClass       = var.ingress_controller_name
        ingressClassByName = true
        service = {
          type = "LoadBalancer"
          port = {
            http = 80
          }
        }
        fullnameOverride = "nginx-ingress"
      }
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      commonLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    })
  ]
}
