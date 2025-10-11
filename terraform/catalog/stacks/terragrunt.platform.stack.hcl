// This is a mock infra stack. It should be environment agnostic
// It will be called by the environment terragrunt.hcl stack block

locals {
  env = read_terragrunt_config("${get_terragrunt_dir()}/env.platform.hcl")
}

inputs = merge(local.env.inputs)

unit "metallb-cr" {
    source = "git::https://github.com/shakir85/tf-modules.git//metallb-cr?ref=0.3.6"
    path = "metallb-cr"
}

unit "nginx-ingress" {
    source = "git::https://github.com/shakir85/tf-modules.git//nginx-ingress?ref=0.3.6"
    path = "nginx-ingress"
    depends_on = ["metallb-cr"] // not sure if unit blocks support depends_on
}

unit "csi-driver-nfs" {
    source = "git::https://github.com/shakir85/tf-modules.git//csi-driver-nfs?ref=0.3.6"
    path = "csi-driver-nfs"
}
