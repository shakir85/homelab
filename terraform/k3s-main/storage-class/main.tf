resource "kubernetes_storage_class" "nfs" {
  metadata {
    name = "nfs-client"
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  storage_provisioner = "nfs.csi.k8s.io"

  parameters = {
    server     = "10.10.50.38"
    share      = "/volume1/k3s-main"
    nfsVersion = "4.1"
  }

  reclaim_policy         = "Retain"
  volume_binding_mode    = "Immediate"
  allow_volume_expansion = true

  mount_options = [
    "nfsvers=4.1",
    "hard",
    "timeo=600",
    "retrans=5"
  ]
}
