locals {
  node_specs = {
    small  = { memory = 4096, cores = 2, disk_size = 50, enable_agt = true }
    medium = { memory = 8192, cores = 2, disk_size = 50, enable_agt = true }
    large  = { memory = 16384, cores = 4, disk_size = 50, enable_agt = true }
  }
}

module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = var.environment
  os          = var.os
  flavor      = var.k8s_distro
  cluster     = "${var.k8s_distro}-${var.environment}"
}

# TODO: this is a generic idea but see the if condition below, need to figure out how to handle different node roles
module "nodes" {
  for_each = {
    for k, v in var.nodes :
    k => v if v.role == "control-plane"
  }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = var.proxmox_node_name
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = var.username
  hostname            = var.hostname
  timezone            = var.timezone
  cloud_image_info    = var.cloud_image_info
  memory              = local.node_specs[var.node_size].memory
  cores               = local.node_specs[var.node_size].cores
  disk_size           = local.node_specs[var.node_size].disk_size
  enable_guest_agent  = local.node_specs[var.node_size].enable_agt
  sockets             = 1
  description         = var.description


  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}
