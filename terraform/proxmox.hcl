generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "proxmox" {
  endpoint = "https://10.10.50.20:8006/"
  username = "$${var.pve_user}@pam"
  password = var.pve_pwd
  insecure = true

}
EOF
}

generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~> 1.13.1"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.2"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
  }

  # stub-backend, real backend config is injected above
  backend "s3" {}
}
EOF
}
