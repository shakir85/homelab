terraform {
  required_version = "~> 1.5.7"

  backend "s3" {
    region = "us-east-1"
    key    = "csi_driver_nfs-k3s_main-state"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}
