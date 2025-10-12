include "kubeconfig" {
    path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
    source = "git::https://github.com/shakir85/tf-modules.git//gha-arc?ref=0.3.6"

}

# Place holder - all of this module's vars are TF_VARs
# inputs = {}
