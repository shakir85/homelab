resource "helm_release" "gha_runners" {
  for_each = var.gha_runners

  name             = each.value.gha_runner_release_name
  chart            = "${path.module}/runner-deployment/"
  namespace        = var.namespace
  create_namespace = var.create_namespace

  values = [
    file("${path.module}/values/${each.value.repo_values_file}")
  ]
}
