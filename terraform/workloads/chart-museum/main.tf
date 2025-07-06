module "chartmuseum" {
source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/lxc?ref=v0.2.2"
node_name             = "pve1"
disk_id               = "sda"
ssh_public_key_path   = var.id_rsa_pub
hostname              = "chartmuseum"
template_file_id      = "sda:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
description           = "Manage by Terraform"
ip_config             = "10.10.50.73/24"
network_interface     = "eth0"
os_type               = "unmanaged"
disk_size             = "10"
memory                = 2048
cpu_cores             = 2
unprivileged          = true
firewall              = false
}
