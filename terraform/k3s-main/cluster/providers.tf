provider "proxmox" {
  endpoint  = "https://10.10.50.20:8006/"
  # because pve is self-signed
  insecure  = true
  api_token = var.api_token
}
