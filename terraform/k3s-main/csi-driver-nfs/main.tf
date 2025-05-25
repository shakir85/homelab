resource "helm_release" "csi_driver_nfs" {
  name       = "csi-driver-nfs"
  namespace  = "kube-system"
  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts"
  chart      = "csi-driver-nfs"
  version    = var.csi_driver_nfs_version

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

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
