resource "kubernetes_role" "gha_target_ns_role" {
  metadata {
    name      = var.role_name
    namespace = var.target_namespace
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "services", "pods"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  #   rule {
  #     api_groups = ["networking.k8s.io"]
  #     resources  = ["networkpolicies"]
  #     verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  #   }

  #   rule {
  #     api_groups = ["policy"]
  #     resources  = ["poddisruptionbudgets"]
  #     verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  #   }

  #   rule {
  #     api_groups = [""]
  #     resources  = ["serviceaccounts"]
  #     verbs      = ["get"]
  #   }
}

resource "kubernetes_role_binding" "gha_target_ns_binding" {
  metadata {
    name      = "sa-${var.gha_service_account_name}-${var.gha_service_account_namespace}-binding"
    namespace = var.target_namespace
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.gha_target_ns_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.gha_service_account_name
    namespace = var.gha_service_account_namespace
  }
}
