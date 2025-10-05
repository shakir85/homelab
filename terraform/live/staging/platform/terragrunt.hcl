include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/platform"
}

locals {
  # common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env = read_terragrunt_config("${get_terragrunt_dir()}/env.hcl")
}

dependencies {
  paths = ["../bootstrap"]
}

inputs = merge(local.env.inputs)
