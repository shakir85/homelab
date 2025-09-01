locals {
  kube = {
    context     = "k3s-utils-ctx"
    config_path = "~/.kube/config"
  }

  runner = {
    name = "staging-homelab"
    repo = "homelab"
    org  = "shakir85"
  }
}

inputs = merge(local.kube, local.runner)
