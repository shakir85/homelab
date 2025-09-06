# ------------------------
# -- Provider vars
# ------------------------
variable "pve_user" {
  type = string
}

variable "pve_pwd" {
  type = string
}

variable "id_rsa" {
  type = string
}
# ------------------------
# -- Module vars
# ------------------------
variable "timezone" {
  type    = string
  default = "America/Los_Angeles"
}

variable "id_rsa_pub" {
  type        = string
  description = "Path to a public key to be added to the VM's authorized_keys"
}

variable "cloud_image_info" {
  type        = list(string)
  description = "Hosted cloud image information; [<image_data_store>, <image_name>]"
}

variable "username" {
  type        = string
  description = "Username to set in the cloud-init configuration"
}

variable "disk_name" {
  type        = string
  description = "VM backend data store ID/name"
}

variable "description" {
  type        = string
  description = "Description to set for the VM"
  default     = "Managed by Terraform"
}

variable "proxmox_node_name" {
  type        = string
  description = "Name of the Proxmox node to deploy the VM on"
}

variable "hostname" {
  description = "Hostname to set for the VM"
}

# variable "node_size" {
#   description = "Size of the VM (small, medium, large)"
#   type        = string
#   default     = "small"

#   validation {
#     condition     = contains(["small", "medium", "large"], var.node_size)
#     error_message = "node_size must be one of: small, medium, large."
#   }
# }

variable "cluster" {
  type = list(object({
    name  = string
    size  = string
    count = number
  }))
}
