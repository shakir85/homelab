terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    region = "us-east-1"
    key    = "storage_class-k3s_utils-state"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kube_config_path
  config_context = var.kube_context
}
