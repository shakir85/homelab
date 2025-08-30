resource "kubernetes_role" "this" {
  metadata {
    name      = var.role_name
    namespace = var.namespace
    labels    = var.shared_labels
  }

  # Core API resources - pods, services, configmaps, SAs
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "persistentvolumeclaims", "persistentvolumes", "serviceaccounts", "statefulsets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

  # Helm itself interacts with K8s Secrets to manage its internal release state.
  # It can be configured to store its state in ConfigMaps instead via `--storage configmaps`
  # But I don't want to change helm's default functionality / settings.
  # Maybe a good TODO task candidate?!
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]

  }

  # Deployments and ReplicaSets
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

  # For Ingress resources
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

}

resource "kubernetes_role_binding" "this" {
  metadata {
    name      = "sa-${var.service_account_name}-${var.service_account_namespace}-binding"
    namespace = var.namespace
    labels    = var.shared_labels
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.service_account_name
    namespace = var.service_account_namespace
  }
}
