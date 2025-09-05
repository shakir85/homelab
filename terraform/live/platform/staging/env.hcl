locals{
  kube = {
    config_path    = "~/.kube/config"
    config_context = "k3s-utils-ctx"
  }

  metallb = {
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.95-10.10.50.99"]
    metallb_namespace      = "metallb-system"
  }

  nginx-ingress = {
    nginx_namespace         = "ingress-nginx"
    ingress_controller_name = "nginx"
  }

}

inputs = merge(local.kube, local.metallb, local.nginx-ingress)
