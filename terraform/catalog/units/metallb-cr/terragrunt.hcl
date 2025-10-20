include "kubeconfig" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/shakir85/tf-modules.git//metallb-cr?ref=0.3.8"

}

inputs = {
  ipv4_address_pool_name = values.ipv4_address_pool_name
  ipv4_address_pools     = values.ipv4_address_pools
  kube_namespace         = values.metallb_namespace
  config_path            = values.config_path
  config_context         = values.config_context
}
