generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "helm" {
  kubernetes = {
    config_path = var.config_path
  }
}

provider "kubernetes" {
  config_path = var.config_path
  config_context = var.config_context
}
EOF
}
