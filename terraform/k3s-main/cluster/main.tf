module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = "prod"
  os          = "debian12"
  flavor      = "k3s"
  cluster     = "k3s-main"
}

module "control_plane_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "control-plane"
  }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "k3s-main-ctrl"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = 8192
  cores               = 2
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."
  enable_guest_agent  = true

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}

module "nodes_group_large_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "large"
  }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = each.key
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = 16384
  cores               = 4
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."
  enable_guest_agent  = true

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}

module "nodes_group_medium_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "medium"
  }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = each.key
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = 8192
  cores               = 2
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."
  enable_guest_agent  = true

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}

module "nodes_group_small_vms" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "worker" && v.size == "small"
  }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = each.key
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = 4096
  cores               = 2
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."
  enable_guest_agent  = true

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}
