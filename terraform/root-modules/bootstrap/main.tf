// what goes here
// arc + cert manager
// runners + k8s resources

module "cert-manager" {
  source = "git::https://github.com/shakir85/tf-modules.git//cert-manager?ref=v0.3.1-alpha"
}

module "gha-arc" {
  source                     = "git::https://github.com/shakir85/tf-modules.git//gha-arc?ref=v0.3.1-alpha"
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_private_key     = var.github_app_private_key

  depends_on = [module.cert-manager]
}

module "runner-deployment" {
  source           = "git::https://github.com/shakir85/tf-modules.git//gha-runner?ref=v0.3.1-beta"
  kube_namespace   = "runners"
  create_namespace = true
  runner_name      = var.runner_name
  repo             = "homelab"
  org              = "shakir85"

  depends_on = [module.gha-arc]
}

