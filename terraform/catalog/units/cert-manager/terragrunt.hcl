include "kubeconfig" {
    path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
    source = "git::https://github.com/shakir85/tf-modules.git//cert-manager?ref=0.3.6"

}

# Place holder
# inputs = {}
