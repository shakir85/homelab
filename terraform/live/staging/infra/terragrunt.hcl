include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/infra"
}

locals {
  env = read_terragrunt_config("${get_terragrunt_dir()}/env.hcl")
}

dependencies {
  paths = ["../cluster"]
}

inputs = local.env.inputs
