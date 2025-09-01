provider "helm" {
  kubernetes = {
    config_path = var.kube_config
  }
}

provider "kubernetes" {
  config_path = var.kube_config
}
