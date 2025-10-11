// root.hcl should be sourced in the environment terragrunt.hcl
include "proxmox" {
  path = find_in_parent_folders("proxmox.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_terragrunt_dir()}../../../catalog/stacks/terragrunt.compute.stack.hcl"
}

inputs = {
  proxmox_node_name = "pve1"
  disk_name         = "sdd"
  cloud_image_info  = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  description       = "Managed by Terragrunt."
  cluster = [
    {
      name  = "dev-ctrl"
      size  = "medium"
      count = 1
      macs  = ["32:fe:ce:8c:3b:a8"]
    },
    {
      name  = "dev-small-w"
      size  = "small"
      count = 2
      macs = [
        "32:63:71:b2:58:c8",
        "f6:24:d1:06:56:46",
      ]
    }
  ]
}

# stack "infra" {
#   source = "${get_terragrunt_dir()}/../catalog/stacks/terragrunt.infra.stack.hcl"
#   values = {
#     config_path    = local.kube.config_path
#     config_context = local.kube.config_context
#   }
# }

# stack "platform" {
#   source = "${get_terragrunt_dir()}/../catalog/stacks/terragrunt.platform.stack.hcl"
#   values = {
#     config_path    = local.kube.config_path
#     config_context = local.kube.config_context
#   }
# }

# locals {
#     kube = {
#     config_path    = "~/.kube/dev-config"
#     config_context = "dev"
#     }
# }
