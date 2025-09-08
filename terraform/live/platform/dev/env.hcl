locals{
  kube = {
    config_path    = "~/.kube/config"
    config_context = "dev-ctx"
  }

  metallb = {
    metallb_namespace      = "metallb-system"
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.98-10.10.50.99"]
  }

  nginx-ingress = {
    nginx_namespace = "ingress-nginx"
  }
}

inputs = merge(local.kube, local.metallb, local.nginx-ingress)
