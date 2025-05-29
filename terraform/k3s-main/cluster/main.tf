# This is a dynamic resource provisioning
# which will iterate over the 'nodes' var
# since there are very minimal differences
# between the cluster VMs resources.

variable "nodes" {
  type = map(object({
    role = string
  }))
  default = {
    "k3s-main-ctrl"   = { role = "control-plane" }
    "k3s-main-node-1" = { role = "worker" }
    "k3s-main-node-2" = { role = "worker" }
    "k3s-main-node-3" = { role = "worker" }
    "k3s-main-node-4" = { role = "worker" }
  }
}

module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = "prod"
  os          = "debian12"
  flavor      = "k3s"
  cluster     = "k3s-main"
}

module "k3s_vms" {
  for_each            = var.nodes
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.2.2"
  proxmox_node_name   = "pve1"
  disk_name           = "sdd"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = each.key
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  memory              = each.value.role == "control-plane" ? 16384 : 8192
  cores               = 2
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}

# Print any output block from the main module
output "k3s_vms_outputs" {
  value = { for key, mod in module.k3s_vms : key => mod }
}
