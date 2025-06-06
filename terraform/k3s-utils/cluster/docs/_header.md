## Usage
This module provisions a dynamic set of K3s cluster VMs on Proxmox using the `proxmox/vm` module. It loops over the `nodes` variable (a map of hostnames to node roles), creating a VM for each entry.

The `tags` module is used to generate consistent metadata tags, and the node role is dynamically injected into each VM.

Each VM is configured with:
    - A Debian 12 cloud image
    - SSH access
    - Sizing based on role (control-plane vs. worker)
    - Metadata such as timezone and description

 
 Example:
 
 ```hcl
module "tags" {
  source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
  environment = "prod"
  os          = "debian12"
  flavor      = "k3s"
  cluster     = "k3s-utils"
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
```
The output `k3s_vms_outputs` returns a map of all VM module outputs keyed by hostname.
 