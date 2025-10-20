unit "loadbalancer" {
  source = "${get_repo_root()}/terraform/catalog/units/loadbalancer"
  path   = "loadbalancer"
  values = {
    metallb_namespace = "metallb"
    create_namespace  = true
    config_path       = "~/.kube/staging-config"
    config_context    = "staging"
  }
}

unit "csi-driver" {
  source = "${get_repo_root()}/terraform/catalog/units/csi-driver-nfs"
  path   = "csi-driver"
  values = {
    config_path    = "~/.kube/staging-config"
    config_context = "staging"
  }
}

unit "metallb-cr" {
  source = "${get_repo_root()}/terraform/catalog/units/metallb-cr"
  path   = "metallb-cr"
  values = {
    metallb_namespace      = "metallb-system"
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.96-10.10.50.97"]
    config_path            = "~/.kube/staging-config"
    config_context         = "staging"
  }
}
