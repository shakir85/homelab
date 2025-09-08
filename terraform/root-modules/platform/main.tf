module "metallb-cr" {
  source                 = "git::https://github.com/shakir85/tf-modules.git//metallb-cr?ref=v0.3.3"
  ipv4_address_pool_name = var.ipv4_address_pool_name
  ipv4_address_pools     = var.ipv4_address_pools
  kube_namespace         = var.metallb_namespace

}

module "nginx-ingress" {
  source         = "git::https://github.com/shakir85/tf-modules.git//nginx-ingress?ref=v0.3.3"
  kube_namespace = var.nginx_namespace

  depends_on = [module.metallb-cr]
}

module "csi-driver-nfs" {
  source = "git::https://github.com/shakir85/tf-modules.git//csi-driver-nfs?ref=v0.3.3"
}
