module "cert-manager" {
  source    = "../../modules/cert-manager"
  namespace = var.kube_namespace
}
