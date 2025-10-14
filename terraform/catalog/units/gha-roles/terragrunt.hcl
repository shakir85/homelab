include "kubeconfig" {
  path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
  source = "git::https://github.com/shakir85/tf-modules.git//gha-roles?ref=0.3.6"
}

inputs = {
  runner_service_account_namespace = values.runner_service_account_namespace
  runner_service_account_name      = values.runner_service_account_name
  role_name                        = values.role_name
}
