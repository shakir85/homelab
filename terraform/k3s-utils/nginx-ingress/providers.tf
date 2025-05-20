terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    region = "us-east-1"
    key    = "nginx_ingress-k3s_utils-state"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}

provider "kubernetes" {
  config_path = var.kube_config_path
}
