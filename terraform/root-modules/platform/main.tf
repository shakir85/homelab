module "metallb-crd" {
  source                 = "git::https://github.com/shakir85/tf-modules.git//metallb-crd?ref=v0.3.2"
  ipv4_address_pool_name = var.ipv4_address_pool_name
  ipv4_address_pools     = var.ipv4_address_pools
  kube_namespace         = var.metallb_namespace

}

module "nginx-ingress" {
  source         = "git::https://github.com/shakir85/tf-modules.git//nginx-ingress?ref=patch-platform"
  kube_namespace = var.nginx_namespace

  depends_on = [module.metallb-crd]
}

module "csi-driver-nfs" {
  source = "git::https://github.com/shakir85/tf-modules.git//csi-driver-nfs?ref=v0.3.2"
}
