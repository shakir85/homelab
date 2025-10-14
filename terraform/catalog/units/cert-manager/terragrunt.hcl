include "k8s-providers" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  kube_namespace = values.kube_namespace
  config_path    = "~/.kube/config"
  config_context = "dev"
}

terraform {
  source = "git::https://github.com/shakir85/tf-modules.git//cert-manager?ref=0.3.6"
}
