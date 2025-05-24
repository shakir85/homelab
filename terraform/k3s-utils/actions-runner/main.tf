resource "helm_release" "gha_runners" {
  name             = var.gha_runner_name
  chart            = "../../../helm/charts/gha-runners/"
  namespace        = var.kube_namespace
  create_namespace = false

  set {
    name  = "runner_deployment_name"
    value = var.runner_name
  }

  set {
    name  = var.runner_type
    value = "true"
  }
  values = [
    yamlencode({
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    })
  ]
  # This comment helped me tremendously in properly passing YAML list attributes from TF:
  # https://github.com/hashicorp/terraform-provider-helm/issues/1022#issuecomment-1370071345
  # TODO: this is broken, needs to be fixed. Use default GHA runner label "self-hosted"
  #   values = [
  #     yamlencode({
  #       gloab = {
  #         labels = "k3s_utils"
  #       }
  #     })
  #   ]
}

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
