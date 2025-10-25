include "kubeconfig" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/stackgarage/tf-modules.git//gha-arc?ref=0.3.8"
}

inputs = {
  config_path                = values.config_path
  config_context             = values.config_context
  github_app_id              = get_env("TF_VAR_github_app_id")
  github_app_installation_id = get_env("TF_VAR_github_app_installation_id")
  github_app_private_key     = get_env("TF_VAR_github_app_private_key")
}

dependency "cert-manager" {
  config_path = "../cert-manager/"
  mock_outputs = {
    cert-manager_output = "mock-cert-manager-output"
  }
}
