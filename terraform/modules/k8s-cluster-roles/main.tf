resource "kubernetes_cluster_role" "this" {
  metadata {
    name = var.role_name
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get", "list", "create"]
  }

  rule {
    api_groups = [""]
    resources  = ["persistentvolumes"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "sa-${var.service_account_name}-${var.service_account_namespace}-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.this.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.service_account_name
    namespace = var.service_account_namespace
  }
}
