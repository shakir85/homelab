locals{
  kube = {
    config_path    = "~/.kube/staging-config"
    config_context = "staging-ctx"
  }

  metallb = {
    metallb_namespace      = "metallb-system"
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.96-10.10.50.98"]
  }

  nginx-ingress = {
    nginx_namespace         = "ingress-nginx"
  }
}

inputs = merge(local.kube, local.metallb, local.nginx-ingress)
