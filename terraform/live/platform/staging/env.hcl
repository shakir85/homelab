inputs = {
  # kube_context     = "k3s-staging-ctx"
  environment      = "staging"
  metallb_ipv4_address_pools = ["192.168.1.240-192.168.1.250"]
  metallb_ipv4_address_pool_name = "default-pool"
}
