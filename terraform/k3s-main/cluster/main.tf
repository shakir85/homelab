/**
 * ## Usage
 *
 * This configuration provisions a dynamic K3s cluster on Proxmox by grouping and filtering VMs based on their `role` and `size`.
 * It uses the [proxmox/vm](https://github.com/shakir85/proxmox-tf-modules) module to create each VM, and the [tags](https://github.com/shakir85/proxmox-tf-modules/tree/main/proxmox/tags) module to provide consistent tagging metadata.
 *
 * The `nodes` variable defines a map of hostnames, each with a role (`control-plane` or `worker`) and optional size (`small`, `medium`, `large`).
 * Modules are grouped accordingly to provision appropriately sized VMs.
 *
 * Each VM is configured with:
 * - A Debian 12 cloud image
 * - SSH access using a specified public key
 * - Sizing based on the `role` and `size`
 * - Metadata such as timezone and description
 *
 * Example:
 *
 * ```hcl
 * variable "nodes" {
 *   type = map(object({
 *     role = string
 *     size = optional(string)
 *   }))
 *   default = {
 *     "k3s-main-ctrl"   = { role = "control-plane" }
 *     "k3s-main-node-1" = { role = "worker", size = "small" }
 *     "k3s-main-node-2" = { role = "worker", size = "medium" }
 *     "k3s-main-node-3" = { role = "worker", size = "medium" }
 *     "k3s-main-node-4" = { role = "worker", size = "large" }
 *   }
 * }
 *
 * module "tags" {
 *   source      = "git::https://github.com/shakir85/terraform_modules.git//proxmox/tags?ref=v0.2.2"
 *   environment = "prod"
 *   os          = "debian12"
 *   flavor      = "k3s"
 *   cluster     = "k3s-main"
 * }
 *
 * module "control_plane_vms" {
 *   for_each = {
 *     for k, v in var.nodes :
 *     k => v if v.role == "control-plane"
 *   }
 *   ...
 * }
 *
 * module "nodes_group_large_vms" {
 *   for_each = {
 *     for k, v in var.nodes :
 *     k => v if v.role == "worker" && v.size == "large"
 *   }
 *   ...
 * }
 *
 * module "nodes_group_medium_vms" {
 *   for_each = {
 *     for k, v in var.nodes :
 *     k => v if v.role == "worker" && v.size == "medium"
 *   }
 *   ...
 * }
 *
 * module "nodes_group_small_vms" {
 *   for_each = {
 *     for k, v in var.nodes :
 *     k => v if v.role == "worker" && v.size == "small"
 *   }
 *   ...
 * }
 * ```
 *
 * Each VM receives tags including its role, and resources are scaled by their `size` classification.
 * The output `k3s_vms_outputs` can be used to collect and interact with all provisioned VMs.
 */

variable "nodes" {
  type = map(object({
    role = string
    size = optional(string)
  }))
  default = {
    "k3s-main-ctrl"   = { role = "control-plane" }
    "k3s-main-node-1" = { role = "worker", size = "small" }
    "k3s-main-node-2" = { role = "worker", size = "medium" }
    "k3s-main-node-3" = { role = "worker", size = "medium" }
    "k3s-main-node-4" = { role = "worker", size = "large" }
  }
}

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
  cores               = 6
  sockets             = 1
  disk_size           = 50
  description         = "Managed by Terraform."

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

  tags = [
    for key, value in module.tags.tags :
    key == "role" ? each.value.role : value
  ]
}
