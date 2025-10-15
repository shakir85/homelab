include "kubeconfig" {
  path = "${get_repo_root()}/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/shakir85/tf-modules.git//gha-roles?ref=0.3.6"
}

inputs = {

  #   role_name                        = "${module.runner-deployment.runner_name}-role"
  #   runner_service_account_name      = "${module.runner-deployment.runner_name}-sa"
  #   runner_service_account_namespace = module.runner-deployment.kube_namespace
  #   target_namespaces                = var.rbac_namespaces
  runner_service_account_namespace = values.runner_service_account_namespace
  runner_service_account_name      = values.runner_service_account_name
  role_name                        = values.role_name

  # dependency.vpc.outputs.name
}

dependency "gha-runner" {
  config_path = "../gha-runner/"
  #   mock_outputs = {
  #     gha-arc_output = "mock-gha-arc-output"
  #   }
}
