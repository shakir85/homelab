include "k8s-providers" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/stackgarage/tf-modules.git//gha-runner?ref=0.3.8"

}

inputs = {
  kube_namespace   = "runners"
  create_namespace = true
  runner_name      = values.runner_name
  repo             = "homelab"
  org              = "stackgarage"
  config_path      = values.config_path
  config_context   = values.config_context
}

dependency "gha-arc" {
  config_path = "../gha-arc/"
  mock_outputs = {
    gha-arc_output = "mock-gha-arc-output"
  }
}
