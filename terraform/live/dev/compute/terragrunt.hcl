include {
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
      name  = "dev-ctrl",
      size  = "medium",
      count = 1,
      macs  = ["32:fe:ce:8c:3b:a8"]
    },
    {
      # Node group - small
      name  = "dev-small-w",
      size  = "small",
      count = 2,
      macs  = [
        "32:63:71:b2:58:c8",
        "f6:24:d1:06:56:46",
      ]
    },
  ]
}

inputs = merge(
  local.common,
  {cluster = local.cluster}
)
