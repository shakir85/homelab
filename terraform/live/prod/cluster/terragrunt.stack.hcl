unit "cluster" {
  source = "${get_repo_root()}/terraform/catalog/units/cluster"
  path   = "cluster"

  values = {
    proxmox_node_name = "pve1"
    disk_name         = "sdd"
    cloud_image_info  = ["sdc", "debian-12-generic-amd64.qcow2.img"]
    description       = "Managed by Terragrunt."
    env               = "prod" # for pulling the correct inventory file
    cluster = [
      {
        # Control plane
        name  = "prod-ctrl"
        size  = "medium"
        count = 1
        macs  = [""]
      },
      {
        # Node group - medium
        name  = "prod-medium-w"
        size  = "medium"
        count = 4
        macs = [
          "",
          "",
        ]
      },
    ]
  }
}
