// Process environment specific variables for the infra stack here
// These variables are declared in the raw Terraform modules.
locals {
  metallb = {
    metallb_namespace = "metallb-system"
    create_namespace = true
  }

  runner = {
    kube_namespace   = "runners"
    create_namespace = true
    name             = "dev-homelab"
    repo             = "homelab"
    org              = "shakir85"
    target_namespaces = ["kube-system", "cert-manager", "runners", "arc-system"]
  }
}

inputs = merge(local.kube, local.runner, local.metallb)
