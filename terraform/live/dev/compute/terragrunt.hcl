include "proxmox" {
  path = find_in_parent_folders("proxmox.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/proxmox/cluster"

  after_hook "ansible_provision" {
    commands    = ["apply"]
    working_dir = "${get_repo_root()}/ansible"
    execute = [
      "ansible-playbook",
      "-i", "inventory/dev/k3s.yml",
      "k3s_site.playbook.yml"
    ]
    run_on_error = false
  }
}

locals {
  common = read_terragrunt_config("${get_terragrunt_dir()}/common.hcl").locals

  cluster = [
    {
      # Control plane
      name  = "dev-ctrl",
      size  = "medium",
      count = 1,
      macs  = ["32:fe:ce:8c:3b:a8"]
    },
    {
      # Node group - small
      name  = "dev-small-w",
      size  = "small",
      count = 2,
      macs = [
        "32:63:71:b2:58:c8",
        "f6:24:d1:06:56:46",
      ]
    },
  ]
}

inputs = merge(
  local.common,
  { cluster = local.cluster }
)
