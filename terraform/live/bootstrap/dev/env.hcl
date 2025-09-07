locals {
  kube = {
    config_path    = "~/.kube/config"
    config_context = "dev-ctx"
  }

  runner = {
    name = "dev-homelab"
    repo = "homelab"
    org  = "shakir85"
    rbac_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }
}

inputs = merge(local.kube, local.runner)
