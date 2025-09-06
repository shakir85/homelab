include {
  path = find_in_parent_folders("proxmox.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/root-modules/cluster"
}

locals {
  common = read_terragrunt_config("${get_terragrunt_dir()}/common.hcl").locals

  cluster = [
    { name = "ctrl",   size = "large",  count = 1 },
    { name = "wx", size = "medium", count = 2 },
    { name = "wy", size = "small",  count = 1 },
  ]
}

inputs = merge(
  local.common,
  {cluster = local.cluster}
)
