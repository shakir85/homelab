include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/root-modules/platform"
}

locals {
  # common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env    = read_terragrunt_config("${get_terragrunt_dir()}/env.hcl")
}

inputs = merge(local.env.inputs)
