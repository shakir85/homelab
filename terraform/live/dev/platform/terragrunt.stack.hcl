unit "loadbalancer" {
  source = "${get_repo_root()}/terraform/catalog/units/loadbalancer"
  path   = "loadbalancer"
  values = {
    metallb_namespace = "metallb"
    create_namespace  = true
    config_path       = "~/.kube/dev-config"
    config_context    = "dev"
  }
}

unit "csi-driver" {
  source = "${get_repo_root()}/terraform/catalog/units/csi-driver-nfs"
  path   = "csi-driver"
  values = {
    config_path    = "~/.kube/dev-config"
    config_context = "dev"
  }
}

unit "metallb-cr" {
  source = "${get_repo_root()}/terraform/catalog/units/metallb-cr"
  path   = "metallb-cr"
  values = {
    metallb_namespace      = "metallb-system"
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.98-10.10.50.99"]
    config_path            = "~/.kube/dev-config"
    config_context         = "dev"
  }
}
