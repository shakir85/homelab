resource "helm_release" "csi_driver_nfs" {
  name       = "csi-driver-nfs"
  namespace  = "kube-system"
  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts"
  chart      = "csi-driver-nfs"
  version    = var.chart_version

  values = [
    yamlencode({
      externalSnapshotter = {
        enabled = true
      }
      controller = {
        runOnControlPlane = true
        replicas          = 2
      }
    })
  ]
}
