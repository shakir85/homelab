unit "cluster" {
  source = "${get_repo_root()}/terraform/catalog/units/cluster"
  path   = "cluster"

  values = {
    proxmox_node_name = "pve1"
    disk_name         = "sdd"
    cloud_image_info  = ["sdc", "debian-12-generic-amd64.qcow2.img"]
    description       = "Managed by Terragrunt."
    env               = "staging" # for pulling the correct inventory file
    cluster = [
      {
        # Control plane
        name  = "staging-ctrl"
        size  = "medium"
        count = 1
        macs  = ["bc:24:11:82:be:58"]
      },
      {
        # Node group - small
        name  = "staging-small-w"
        size  = "small"
        count = 2
        macs = [
          "bc:24:11:19:32:af",
          "bc:24:11:23:9b:a2",
        ]
      },
    ]
  }
}
