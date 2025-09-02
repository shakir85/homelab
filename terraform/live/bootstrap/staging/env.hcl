locals {
  kube = {
    config_path    = "~/.kube/config"
    config_context = "k3s-utils-ctx"
  }

  runner = {
    name = "staging-homelab"
    repo = "homelab"
    org  = "shakir85"
    rbac_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }
}

inputs = merge(local.kube, local.runner)
