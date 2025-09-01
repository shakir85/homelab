module "metallb" {
  source           = "git::https://github.com/shakir85/tf-modules.git//metallb?ref=v0.3.1"
  kube_namespace   = "metallb-system"
  create_namespace = true
}

module "metallb-crd" {
  source                 = "../../modules/metallb-crd"
  ipv4_address_pool_name = var.metallb_ipv4_address_pool_name
  ipv4_address_pools     = var.metallb_ipv4_address_pools
  kube_namespace         = "metallb-system"

  depends_on = [module.metallb]
}

module "nginx-ingress" {
  source                  = "git::https://github.com/shakir85/tf-modules.git//nginx-ingress?ref=v0.3.1"
  kube_namespace          = "nginx-ingress"
  create_namespace        = true
  ingress_controller_name = "nginx"

  depends_on = [module.metallb]
}

module "csi-driver-nfs" {
  source = "git::https://github.com/shakir85/tf-modules.git//csi-driver-nfs?ref=v0.3.1"
}
