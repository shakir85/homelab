module "chartmuseum" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/lxc?ref=v0.3.0"
  node_name           = "pve1"
  ssh_public_key_path = var.id_rsa_pub
  hostname            = "chartmuseum"
  template_file_id    = "sda:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  description         = "Manage by Terraform"
  ipv4_config         = "dhcp" # set static ip on pfsense not here
  os_type             = "ubuntu"
  disk_size           = "10"
  disk_id             = "sda"
}
