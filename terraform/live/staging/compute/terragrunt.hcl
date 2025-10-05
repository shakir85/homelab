include "proxmox" {
  path = find_in_parent_folders("proxmox.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/proxmox/cluster"
}

locals {
  common = read_terragrunt_config("${get_terragrunt_dir()}/common.hcl").locals

  cluster = [
    {
      # Control plane
      name  = "staging-ctrl",
      size  = "large",
      count = 1
      macs  = ["bc:24:11:82:be:58"]
    },
    {
      # Node group - small
      name  = "staging-small-w",
      size  = "small",
      count = 2
      macs = [
        "bc:24:11:19:32:af",
        "bc:24:11:23:9b:a2",
        "",
      ]
    },
  ]
}

inputs = merge(
  local.common,
  { cluster = local.cluster }
)
