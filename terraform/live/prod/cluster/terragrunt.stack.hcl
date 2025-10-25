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
        macs  = ["82:79:52:6f:eb:f7"]
      },
      {
        # Node group - medium
        name  = "prod-medium-w"
        size  = "medium"
        count = 4
        macs = [
          "32:f7:29:57:0f:d1",
          "6a:bb:75:6e:56:96",
          "de:b2:c6:43:d8:7b",
          "62:6a:7a:72:b8:18"
        ]
      },
    ]
  }
}
