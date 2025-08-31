include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/root-modules/platform"
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = local.env.inputs
