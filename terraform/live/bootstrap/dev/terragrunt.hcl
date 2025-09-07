include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/root-modules/bootstrap"
}

locals {
  env = read_terragrunt_config("${get_terragrunt_dir()}/env.hcl")
}

inputs = local.env.inputs
