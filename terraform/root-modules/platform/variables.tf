variable "config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
}

variable "config_context" {
  description = "Kubernetes context to use"
  type        = string
}

variable "ipv4_address_pools" {
  description = "List of IPv4 address pools for MetalLB"
  type        = list(string)
}

variable "ipv4_address_pool_name" {
  description = "Name of the IPv4 address pool for MetalLB"
  type        = string
}

variable "metallb_namespace" {
  description = "Kubernetes namespace for MetalLB"
  type        = string
}

variable "nginx_namespace" {
  description = "Kubernetes namespace for NGINX Ingress Controller"
  type        = string

}

variable "ingress_controller_name" {
  description = "Name of the NGINX Ingress Controller"
  type        = string

}
