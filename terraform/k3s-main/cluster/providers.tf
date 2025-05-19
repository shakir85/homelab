terraform {
  required_version = ">= 1.5.7"
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
      version = ">= 2.5.1"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.10.50.20:8006/"
  username = "${var.pve_user}@pam" // typically root@pam
  password = var.pve_pwd
  # because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent       = false
    private_key = file(var.id_rsa)
    username    = var.pve_user
    node {
      name    = "pve1"
      address = "10.10.50.20"
    }
  }
}
