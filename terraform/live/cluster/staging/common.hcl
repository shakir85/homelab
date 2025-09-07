locals {
  hostname = "staging"
  proxmox_node_name = "pve1"
  disk_name = "sdd"
  username = "shakir"
  cloud_image_info = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  description = "Managed by Terragrunt."
}
