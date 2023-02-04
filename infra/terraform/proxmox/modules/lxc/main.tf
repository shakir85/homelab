resource "proxmox_lxc" "basic" {
  for_each = var.lxc

  target_node  = "pve"
  hostname     = each.value.container_name
  ostemplate   = "local:vztmpl/${each.value.container_template}"
  password     = var.lxcpwd
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    // To let LXC containers use 'local' for storage, run this command on the host:
    // pvesm set local --content backup,images,iso,rootdir,snippets,vztmpl
    storage = each.value.storage_pool
    size    = each.value.hdd_size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = each.value.ip_address
  }
  # to enable Docker on LXC
  features {
    keyctl  = true
    nesting = true
  }
}
