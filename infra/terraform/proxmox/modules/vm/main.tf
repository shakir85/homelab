/*
Requirement:
  - A pre-configured cloud-init template
  - If used as a module, you must declare a provider here + the root.tf (main.tf) module
*/
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

resource "proxmox_vm_qemu" "vm_resource" {

  name        = var.hostname
  desc        = var.vm_description
  target_node = var.target_node
  agent       = 1

  # Read this doc, and understand its implications, before enabling full_clone:
  # https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_copy_and_clone
  # When this attribute is set to 'false', Proxmox will do linked clones.
  # full_clone = false

  os_type   = "cloud-init"
  clone     = var.cloud_init_template
  cpu       = "host"
  cores     = var.cpu_cores
  sockets   = var.cpu_sockets
  memory    = var.memory
  ipconfig0 = "ip=${var.ip_address},ip6=dhcp,gw=${var.default_gateway}"
  tags      = var.tags
  # scsihw = "virtio-scsi-pci"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    # tag = var.vlan_tag
  }

  disk {
    type     = "scsi"
    storage  = var.storage_pool
    size     = var.hdd_size
    slot     = 0
    iothread = 0
    backup   = var.backup_enabled
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  provisioner "remote-exec" {
    inline = ["echo 'wait for ssh...'"]

    connection {
      host        = var.ip_without_cidr
      type        = "ssh"
      user        = var.default_user
      private_key = file("${var.pvt_key_path}")
    }
  }
  # Run Ansible playbook
  # Pass playbook path as a variable
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${var.inventory_path} ${var.ansible_command}"
  }
}
