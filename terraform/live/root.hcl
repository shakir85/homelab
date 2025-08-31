# Terragrunt root
# Example code
remote_state {
  backend = "s3"
  config = {
    bucket         = "my-homelab-terraform"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
