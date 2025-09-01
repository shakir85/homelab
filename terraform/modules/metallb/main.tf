resource "helm_release" "metallb" {
  name       = "metallb"
  namespace  = var.kube_namespace
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = var.chart_version

  create_namespace = var.create_namespace

  values = [
    yamlencode({
      configInline = {}, # Empty to disable legacy config
      controller = {
        labels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      },
      speaker = {
        labels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      },
    })
  ]
}
