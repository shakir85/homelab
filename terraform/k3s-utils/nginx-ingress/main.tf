resource "kubernetes_namespace" "ingress_ns" {
  metadata {
    name = var.kube_namespace
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-name"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = kubernetes_namespace.ingress_ns.metadata[0].name
  values = [
    file("../../../k8s/charts/nginx-ingress/values.yml")
  ]
}
