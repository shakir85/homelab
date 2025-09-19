include {
  path = find_in_parent_folders("proxmox.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/root-modules/cluster"
}

locals {
  common = read_terragrunt_config("${get_terragrunt_dir()}/common.hcl").locals

  cluster = [
    {
      # Control plane
      name  = "dev-ctrl",
      size  = "medium",
      count = 1
    },
    {
      # Node group - small
      name  = "dev-small-w",
      size  = "small",
      count = 2
    },
  ]
}

inputs = merge(
  local.common,
  {cluster = local.cluster}
)
