# ------------------------
# -- Provider vars
# ------------------------
variable "id_rsa_pub" {
  type = string
}

variable "pve_user" {
  type        = string
  description = "Proxmox VE username"
}

variable "pve_pwd" {
  type        = string
  description = "Proxmox VE password"
  sensitive   = true
}

variable "id_rsa" {
  type        = string
  description = "Path to the private SSH key"
}
# ------------------------
# -- Module vars
# ------------------------
variable "nodes" {
  type = map(object({
    role = string
    size = optional(string)
  }))
  default = {
    "k3s-utils-ctrl"   = { role = "control-plane" }
    "k3s-utils-node-1" = { role = "worker", size = "medium" }
    "k3s-utils-node-2" = { role = "worker", size = "medium" }
    "k3s-utils-node-3" = { role = "worker", size = "medium" }
    # "k3s-utils-node-4" = { role = "worker", size = "large" }
  }
}

variable "timezone" {
  type    = string
  default = "America/Los_Angeles"
}

variable "cloud_image_info" {
  type        = list(string)
  description = "Hosted cloud image information; [<image_data_store>, <image_name>]"
}

variable "username" {
  type        = string
  description = "Username to set in the cloud-init configuration"
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

variable "environment" {
  type        = string
  description = "Environment to set for the VM tag"
}

variable "os" {
  type        = string
  description = "OS to set for the VM tag"
}

variable "k8s_distro" {
  type        = string
  description = "Kubernetes distribution to set for the VM tag"
}

variable "hostname" {
  description = "Hostname to set for the VM"
}

variable "node_size" {
  description = "Size of the VM (small, medium, large)"
  type        = string
  default     = "small"

  validation {
    condition     = contains(["small", "medium", "large"], var.node_size)
    error_message = "node_size must be one of: small, medium, large."
  }
}
