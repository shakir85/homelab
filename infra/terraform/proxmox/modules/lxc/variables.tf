/*  Available values for these variables:
      container_template = [
                            ubuntu-20.04-standard_20.04-1_amd64.tar.gz,
                            centos-7-default_20190926_amd64.tar.xz
                            ]
      storage_pool = [local, local-lvm, ssd-r10]
*/
variable "proxmox_host" {
  default = "10.10.50.20"
}

variable "lxc" {
  default = {
    "nginx_proxy" = {
      container_name     = "npm-tftes",
      hdd_size           = "8G",
      storage_pool       = "ssd-r10",
      container_template = "ubuntu-20.04-standard_20.04-1_amd64.tar.gz",
      ip_address         = "10.10.50.35/24"
    },
  }
}

# Use env var, must export TF_VAR_lxcpwd=<passwordValue>
variable "lxcpwd" {
  type      = string
  sensitive = true
}
