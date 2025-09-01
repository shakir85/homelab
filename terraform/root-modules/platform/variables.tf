variable "metallb_ipv4_address_pools" {
  description = "List of IPv4 address pools for MetalLB"
  type        = list(string)
}

variable "metallb_ipv4_address_pool_name" {
  description = "Name of the IPv4 address pool for MetalLB"
  type        = string
}

variable "kube_config" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}
