include "kubeconfig" {
    path = "${get_repo_root()}/k8s-providers.hcl"
}

terraform {
    source = "git::https://github.com/shakir85/tf-modules.git//runner-deployment?ref=0.3.6"

}

inputs = {
    kube_namespace   = "runners"
    create_namespace = true
    name             = values.name
    repo             = "homelab"
    org              = "shakir85"
    target_namespaces = values.target_namespaces
}
