provider "helm" {
  kubernetes = {
    config_path = var.config_path
  }
}

provider "kubernetes" {
  config_path = var.config_path
}
