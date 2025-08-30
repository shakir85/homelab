terraform {
  required_version = "~> 1.13.1"

  backend "s3" {
    region = "us-east-1"
    key    = "monitoring-k3s_main-state"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}
