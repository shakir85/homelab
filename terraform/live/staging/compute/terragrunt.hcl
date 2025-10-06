include "proxmox" {
  path = find_in_parent_folders("proxmox.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/catalog/modules/proxmox/cluster"

  after_hook "ansible_install_collections" {
    commands    = ["apply"]
    working_dir = "${get_repo_root()}/ansible"
    execute = [
      "ansible-galaxy",
      "collection",
      "install",
      "-r",
      "requirements.yml"
    ]
    run_on_error = false
  }

  after_hook "ansible_provision" {
    commands    = ["apply"]
    working_dir = "${get_repo_root()}/ansible"
    execute = [
      "ansible-playbook",
      "-i", "inventory/staging/k3s.yml",
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
      name  = "staging-ctrl",
      size  = "large",
      count = 1
      macs  = ["bc:24:11:82:be:58"]
    },
    {
      # Node group - small
      name  = "staging-small-w",
      size  = "small",
      count = 2
      macs = [
        "bc:24:11:19:32:af",
        "bc:24:11:23:9b:a2",
        "",
      ]
    },
  ]
}

inputs = merge(
  local.common,
  { cluster = local.cluster }
)
