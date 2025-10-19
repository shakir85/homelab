include "kubeconfig" {
  path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
  source = "git::https://github.com/shakir85/tf-modules.git//csi-driver-nfs?ref=0.3.8"

}

inputs = {
  config_path    = values.config_path
  config_context = values.config_context
}
