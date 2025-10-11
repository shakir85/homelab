# ------ Stack specific vars ------
locals {
  env = read_terragrunt_config("${get_terragrunt_dir()}/env.infra.hcl")
}

inputs = local.env.inputs


# ------ Units orchestration ------
unit "loadbalancer" {
  source = "git::https://github.com/shakir85/tf-modules.git//metallb?ref=0.3.6"
  path   = "metallb"
}

unit "cert-manager" {
  source = "git::https://github.com/shakir85/tf-modules.git//cert-manager?ref=0.3.6"
  path   = "cert-manager"
}

# gha-arc depends on cert-manager
dependency "cert-manager" {
  config_path = "cert-manager"
}

unit "gha-arc" {
  source = "git::https://github.com/shakir85/tf-modules.git//gha-arc?ref=0.3.6"
  path   = "gha-arc"
}

# runner-deployment depends on gha-arc
dependency "gha-arc" {
  config_path = "gha-arc"
}

unit "runner-deployment" {
  source = "git::https://github.com/shakir85/tf-modules.git//runner-deployment?ref=0.3.6"
  path   = "runner-deployment"
}

# gha-roles depends on runner-deployment
dependency "runner-deployment" {
  config_path = "runner-deployment"
}

unit "gha-roles" {
  source = "git::https://github.com/shakir85/tf-modules.git//gha-roles?ref=0.3.6"
  path   = "gha-roles"

  values = {
    runner_service_account_namespace = dependency.runner-deployment.outputs.kube_namespace
    runner_service_account_name      = "${dependency.runner-deployment.outputs.runner_name}-role"
    role_name                        = "${dependency.runner-deployment.outputs.runner_name}-role"
  }
}
