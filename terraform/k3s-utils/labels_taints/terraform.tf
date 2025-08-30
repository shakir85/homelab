terraform {
  required_version = "~> 1.13.1"

  backend "s3" {
    region = "us-east-1"
    key    = "labels-k3s_utils-state"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.1"
    }
  }
}
