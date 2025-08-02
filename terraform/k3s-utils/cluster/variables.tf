variable "api_token" {
  type = string
}

variable "id_rsa_pub" {
  type = string
}

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
