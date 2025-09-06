locals {
  node_specs = {
    small  = { memory = 4096, cores = 2, disk_size = 50, enable_agt = true }
    medium = { memory = 8192, cores = 2, disk_size = 50, enable_agt = true }
    large  = { memory = 16384, cores = 4, disk_size = 50, enable_agt = true }
  }
  expanded = flatten([
    for c in var.cluster : [
      for i in range(c.count) : {
        name = c.name
        size = c.size
        idx  = i
      }
    ]
  ])
}

module "cluster" {
  for_each = { for c in local.expanded : "${c.name}-${c.idx}" => c }

  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  hostname            = "${each.value.name}-${each.value.idx}"
  memory              = local.node_specs[each.value.size].memory
  cores               = local.node_specs[each.value.size].cores
  disk_size           = local.node_specs[each.value.size].disk_size
  enable_guest_agent  = local.node_specs[each.value.size].enable_agt
  proxmox_node_name   = var.proxmox_node_name
  disk_name           = var.disk_name
  ssh_public_key_path = var.id_rsa_pub
  username            = var.username
  timezone            = var.timezone
  cloud_image_info    = var.cloud_image_info
  sockets             = 1
  description         = var.description
}
