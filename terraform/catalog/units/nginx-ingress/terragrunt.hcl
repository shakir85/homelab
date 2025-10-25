include "kubeconfig" {
  path = "${get_repo_root()}/terraform/catalog/units/k8s-providers.hcl"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/stackgarage/tf-modules.git//nginx-ingress?ref=0.3.8"

}

dependency "metallb-cr" {
  config_path = "../metallb-cr"
}

inputs = {
  kube_namespace = values.nginx_namespace
  config_path    = values.config_path
  config_context = values.config_context
}
