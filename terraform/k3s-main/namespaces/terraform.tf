terraform {
  required_version = "~> 1.5.7"

  backend "s3" {
    region = "us-east-1"
    key    = "apps_namespace-k3s_main-state"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}
