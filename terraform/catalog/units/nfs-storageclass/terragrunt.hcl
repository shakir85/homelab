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

dependency "gha-arc" {
  config_path = "../csi-driver-nfs/"
  mock_outputs = {
    csi-driver-nfs-mockoutput = "csi-driver-nfs-mockoutput"
  }
}
