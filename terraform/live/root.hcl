# Terragrunt root
# Example code
remote_state {
  backend = "s3"
  config = {
    bucket         = "tfstate.shakir.cloud"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
