/*  Available values for the following variables:
      cloud_init_template = [debian11-cloud, centos7-cloud]
      storage_pool = [local, local-lvm, ssd-r10]
    All paths below are relevant to this Terraform module.

    Proxmox expects IP in CIDR notation
    TF local-exec expects IP without CIDR notation
*/
variable "proxmox_host" {
  default = "10.10.50.20"
}

variable "pvt_key_path" {
  description = "Needed for local-exec provisioner to run Ansible playbooks"
}

variable "default_user" {
  default = "shakir"
}

variable "inventory_path" {
  description = "Ansible inventory file, must be relative to the root.tf file"
}

variable "hostname" {
}

variable "target_node" {
  default = "pve"
}

variable "ip_address" {
  description = "Must be in CIDR notation, e.g. 10.20.30.99/24"
}

variable "default_gateway" {
  default = "10.10.50.10"
}

variable "cpu_cores" {
  type = number
}

variable "cpu_sockets" {
  type = number
}

variable "memory" {
  type        = string
  description = "In MiB (Mebibyte)"
}

variable "hdd_size" {
  type        = string
  description = "In Gibibytes, e.g. 128G"
}

variable "storage_pool" {
  description = "Available pools as of 01/27/23: local, local-lvm, ssd-r10"
}

variable "cloud_init_template" {
  description = "Available template as of 01/27/23: debian11-cloud"
}

variable "vm_description" {
}

variable "tags" {
  description = "Space separated tags"
}

variable "ansible_command" {
  description = "ansible-playbook command. It must be relative to the root.tf file"
}

variable "ip_without_cidr" {
  description = "To be passed to local-exec. No CIDR notation allowed"
}

variable "backup_enabled" {
  type        = number
  description = "Integer value only where: 0 == disabled, 1 == enabled"
}
