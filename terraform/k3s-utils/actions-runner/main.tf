resource "helm_release" "gha_runners" {
  for_each = var.gha_runners

  name             = each.value.gha_runner_release_name
  chart            = "../../../helm/charts/gha-runners/"
  namespace        = "actions"
  create_namespace = false

  values = [
    file("${path.module}/values/${each.value.repo_values_file}")
  ]
}
