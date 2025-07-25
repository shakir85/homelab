terraform {
  required_version = "~> 1.5.7"

  backend "s3" {
    region = "us-east-1"
    key    = "metallb-k3s_utils-state"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
  }
}
