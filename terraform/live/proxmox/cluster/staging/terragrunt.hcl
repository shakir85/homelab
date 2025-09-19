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
      name  = "staging-ctrl",
      size  = "large",
      count = 1
    },
    {
      # Node group - small
      name  = "staging-small-w",
      size  = "small",
      count = 3
    },
  ]
}

inputs = merge(
  local.common,
  {cluster = local.cluster}
)
