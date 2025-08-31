terraform {
  required_version = "~> 1.13.1"

  backend "s3" {
    region = "us-east-1"
    key    = "deleteme-cert_manager-k3s_utils-state"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}
