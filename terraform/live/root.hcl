remote_state {
  backend = "s3"
  config = {
    bucket         = "tfstate.shakir.cloud"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "helm" {
  kubernetes = {
    config_path = var.config_path
  }
}

provider "kubernetes" {
  config_path = var.config_path
}
EOF
}

generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~> 1.13.1"

  # stub-backend, real backend config is injected above
  backend "s3" {}
}
EOF
}
