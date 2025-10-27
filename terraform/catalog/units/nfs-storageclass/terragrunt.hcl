include "kubeconfig" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/k8s/nfs-storageclass"
}

inputs = {
  class_name     = values.class_name
  server         = values.server
  share          = values.share
  config_path    = values.config_path
  config_context = values.config_context
}
# NOTE:
# The dependency 'config_path' is evaluated relative to the directory
# where Terragrunt renders the stack (i.e., inside the `.terragrunt-stack/` folder),
# which is set by the stack file `unit.NAME.path` attribute
# not the original source tree in the catalog/modules/units.
# So, relative paths like "../csi-driver-nfs" may not resolve correctly
# depending on how the stack names and structures its units.
dependency "csi-driver" {
  config_path = "../csi-driver"
  mock_outputs = {
    csi-driver-mockoutput = "csi-driver-mockoutput"
  }
}
