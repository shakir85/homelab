unit "cert-manager" {
  source = "${get_repo_root()}/terraform/catalog/units/cert-manager"
  path   = "cert-manager"
  values = {
    kube_namespace = "cert-manager"
    config_path    = "~/.kube/staging-config"
    config_context = "staging"
  }
}

unit "gha-arc" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-arc"
  path   = "gha-arc"
  values = {
    config_path    = "~/.kube/staging-config"
    config_context = "staging"
  }
}

unit "gha-runner" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-runner"
  path   = "gha-runner"
  values = {
    config_path    = "~/.kube/staging-config"
    config_context = "staging"
    runner_name    = "staging-runner"
  }
}

unit "gha-roles" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-roles"
  path   = "gha-roles"
  values = {
    config_path       = "~/.kube/staging-config"
    config_context    = "staging"
    target_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }
}
