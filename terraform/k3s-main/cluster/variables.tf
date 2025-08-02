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
    "k3s-main-ctrl"   = { role = "control-plane" }
    "k3s-main-node-1" = { role = "worker", size = "small" }
    "k3s-main-node-2" = { role = "worker", size = "medium" }
    "k3s-main-node-3" = { role = "worker", size = "medium" }
    # "k3s-main-node-4" = { role = "worker", size = "large" }
  }
}
