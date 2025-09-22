module "metallb" {
  source           = "git::https://github.com/shakir85/tf-modules.git//metallb?ref=0.3.6"
  kube_namespace   = var.metallb_namespace
  create_namespace = true
}

module "cert-manager" {
  source = "git::https://github.com/shakir85/tf-modules.git//cert-manager?ref=0.3.6"
}

module "gha-arc" {
  source                     = "git::https://github.com/shakir85/tf-modules.git//gha-arc?ref=0.3.6"
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_private_key     = var.github_app_private_key

  depends_on = [module.cert-manager]
}

module "runner-deployment" {
  source           = "git::https://github.com/shakir85/tf-modules.git//gha-runner?ref=0.3.6"
  kube_namespace   = "runners"
  create_namespace = true
  runner_name      = var.name
  repo             = var.repo
  org              = var.org

  depends_on = [module.gha-arc]
}

module "gha-roles" {
  source                           = "git::https://github.com/shakir85/tf-modules.git//gha-roles?ref=0.3.6"
  role_name                        = "${module.runner-deployment.runner_name}-role"
  runner_service_account_name      = "${module.runner-deployment.runner_name}-sa"
  runner_service_account_namespace = module.runner-deployment.kube_namespace
  target_namespaces                = var.rbac_namespaces

  depends_on = [module.runner-deployment]
}
