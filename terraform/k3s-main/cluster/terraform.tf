terraform {
  required_version = "~> 1.13.1"
  backend "s3" {
    region = "us-east-1"
    key    = "vm-k3s-main-state"
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
  }
}
