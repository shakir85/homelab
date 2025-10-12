include "kubeconfig" {
    path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
    source = "git::https://github.com/shakir85/tf-modules.git//metallb?ref=0.3.6"

}

inputs = {
    metallb_namespace = values.metallb_namespace
    create_namespace = values.create_namespace
}
