terraform {
  source = "../modules/cert-manager"
  source = "../modules/arc"
  source = "../modules/runners"
  source = "../modules/cluster-roles"
  source = "../modules/roles"
}

inputs = {
  namespace = "cert-manager"
}
