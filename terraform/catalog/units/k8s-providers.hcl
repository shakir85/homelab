# TODO: move variables declarations to the child module
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
}

variable "config_context" {
  description = "Kubernetes context to use"
  type        = string
}

provider "helm" {
  kubernetes = {
    config_path = var.config_path
    config_context = var.config_context
  }
}

provider "kubernetes" {
  config_path = var.config_path
  config_context = var.config_context
}
EOF
}
