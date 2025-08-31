# Important note:
# Anything that an upgrade needs, put it here. e.g., chart version!

module "metallb" {
  source           = "../metallb"
  kube_context     = var.kube_context
  kube_config_path = var.kube_config_path
}

module "metallb_crds" {
  source           = "../metallb-crds"
  kube_context     = var.kube_context
  kube_config_path = var.kube_config_path
}

module "csi_nfs" {
  source           = "../csi-nfs"
  kube_context     = var.kube_context
  kube_config_path = var.kube_config_path
  chart_version    = "1.17."
}

module "ingress-nginx" {
  source           = "../ingress-nginx"
  kube_context     = var.kube_context
  kube_config_path = var.kube_config_path
  chart_version    = "1.17."
}
