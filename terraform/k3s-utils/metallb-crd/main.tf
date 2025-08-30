module "metallb_crd" {
  source                 = "../../modules/metallb-crd"
  ipv4_address_pool_name = "default-pool"
  ipv4_address_pool      = ["10.10.50.95-10.10.50.99"]
  metallb_namespace      = "metallb-system"
}
