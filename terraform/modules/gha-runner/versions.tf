terraform {
  required_version = "~> 1.13.1"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
  }
}
