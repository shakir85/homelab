locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

unit "loadbalancer" {
  source = "${get_repo_root()}/terraform/catalog/units/loadbalancer"
  path   = "loadbalancer"
  values = {
    metallb_namespace = "metallb-system"
    create_namespace  = true
    config_path       = local.common.locals.kubeconfig_path
    config_context    = local.common.locals.kubeconfig_context
  }
}

unit "csi-driver" {
  source = "${get_repo_root()}/terraform/catalog/units/csi-driver-nfs"
  path   = "csi-driver"
  values = {
    config_path    = local.common.locals.kubeconfig_path
    config_context = local.common.locals.kubeconfig_context
  }
}

unit "metallb-cr" {
  source = "${get_repo_root()}/terraform/catalog/units/metallb-cr"
  path   = "metallb-cr"
  values = {
    metallb_namespace      = "metallb-system"
    ipv4_address_pool_name = "default-pool"
    ipv4_address_pools     = ["10.10.50.98-10.10.50.99"]
    config_path    = local.common.locals.kubeconfig_path
    config_context = local.common.locals.kubeconfig_context
  }
}

unit "nginx-ingress" {
  source = "${get_repo_root()}/terraform/catalog/units/nginx-ingress"
  path   = "nginx-ingress"
  values = {
    kube_namespace = "nginx-ingress"
    config_path    = local.common.locals.kubeconfig_path
    config_context = local.common.locals.kubeconfig_context
  }
}
