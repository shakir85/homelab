resource "helm_release" "gha_runner_controller" {
  name       = "gha-runner-controller"
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set-controller"
  namespace  = var.namespace
  create_namespace = true
  recreate_pods    = true
}

resource "helm_release" "gha_runner_scale_set" {
  name       = "gha-runner-scale-set"
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"
  namespace  = var.namespace
  recreate_pods = true

  set {
    name  = "githubConfigUrl"
    value = "https://github.com/your-org/your-repo"
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

  depends_on = [helm_release.gha_runner_controller]
}

variable "github_token" {

}
