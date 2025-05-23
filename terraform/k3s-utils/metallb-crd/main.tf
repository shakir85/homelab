resource "kubernetes_manifest" "ip_address_pool" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata = {
      name      = var.ipv4_address_pool_name
      namespace = var.kube_namespace
    }
    spec = {
      addresses = var.ipv4_address_pool
    }
  }
}

resource "kubernetes_manifest" "l2_advertisement" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "L2Advertisement"
    metadata = {
      name      = "main-advertisement"
      namespace = var.kube_namespace
    }
    spec = {
      ipAddressPools = [var.ipv4_address_pool_name]
    }
  }

  depends_on = [kubernetes_manifest.ip_address_pool]
}
