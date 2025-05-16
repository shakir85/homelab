resource "helm_release" "gha_runner_controller" {
  name       = var.gha_controller_name
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set-controller"
  namespace  = var.namespace
  create_namespace = true
  recreate_pods    = true
}

resource "helm_release" "gha_runner_scale_set" {
  name       = var.gha_scale_set_name
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"
  namespace  = var.namespace
  recreate_pods = true

  set {
    name  = "githubConfigUrl"
    value = "https://github.com/${var.repository}"
  }

  set {
    name  = "githubConfigSecret.github_token"
    value = var.github_token
  }

  set {
    name  = "containerMode.type"
    value = "containerd"
  }

  set {
    name  = "containerMode.containerdNamespace"
    value = "k8s.io"
  }

  set {
    name  = "labels"
    value = var.runner_labels
  }

  depends_on = [helm_release.gha_runner_controller]
}
