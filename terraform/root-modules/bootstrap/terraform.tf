terraform {
  required_version = "~> 1.13.1"

  # stub-backend, terragrunt sets the backend details in root.hcl
  backend "s3" {}

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
  }
}
