locals {
  kube = {
    config_path    = "~/.kube/dev-config"
    config_context = "dev"
  }

  runner = {
    name            = "dev-homelab"
    repo            = "homelab"
    org             = "shakir85"
    rbac_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }

  metallb = {
    metallb_namespace = "metallb-system"
  }
}

inputs = merge(local.kube, local.runner, local.metallb)
