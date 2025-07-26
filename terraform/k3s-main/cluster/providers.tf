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
