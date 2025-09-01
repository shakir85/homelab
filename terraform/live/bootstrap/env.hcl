locals {
  kube = {
    # context     = "k3s-staging-ctx"
    config_path = "~/.kube/config"
  }

  runner = {
    name = "homelab-runner"
    repo = "homelab"
    org  = "shakir85"
  }

  env = {
    environment = "bootstrap"
  }
}

inputs = merge(local.kube, local.runner, local.env)
