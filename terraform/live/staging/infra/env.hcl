locals {
  kube = {
    config_path    = "~/.kube/staging-config"
    config_context = "staging"
  }

  runner = {
    name            = "staging-homelab"
    repo            = "homelab"
    org             = "shakir85"
    rbac_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }

  metallb = {
    metallb_namespace = "metallb-system"
  }
}

inputs = merge(local.kube, local.runner, local.metallb)
