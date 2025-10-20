locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

unit "cert-manager" {
  source = "${get_repo_root()}/terraform/catalog/units/cert-manager"
  path   = "cert-manager"
  values = {
    kube_namespace = "cert-manager"
    config_path       = local.common.locals.kubeconfig_path
    config_context    = local.common.locals.kubeconfig_context
  }
}

unit "gha-arc" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-arc"
  path   = "gha-arc"
  values = {
    config_path    = local.common.locals.kubeconfig_path
    config_context = local.common.locals.kubeconfig_context
  }
}

unit "gha-runner" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-runner"
  path   = "gha-runner"
  values = {
    config_path    = local.common.locals.kubeconfig_path
    config_context = local.common.locals.kubeconfig_context
    runner_name    = "staging-runner"
  }
}

unit "gha-roles" {
  source = "${get_repo_root()}/terraform/catalog/units/gha-roles"
  path   = "gha-roles"
  values = {
    config_path       = local.common.locals.kubeconfig_path
    config_context    = local.common.locals.kubeconfig_context
    target_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }
}
