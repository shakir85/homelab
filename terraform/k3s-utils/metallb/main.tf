module "metallb" {
  source          = "../../modules/metallb"
  release_name    = "metallb"
  metallb_version = "0.14.5"
}
