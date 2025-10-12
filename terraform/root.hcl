remote_state {
  backend = "s3"
  config = {
    bucket  = "tfstate.shakir.cloud"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~> 1.13.1"

  # Required stub-backend, real backend config is injected above
  backend "s3" {}
}
EOF
}
