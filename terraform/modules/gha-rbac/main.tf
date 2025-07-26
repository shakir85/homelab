terraform {
  required_version = "~> 1.5.7"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
  }
}

resource "kubernetes_role" "gha_target_ns_role" {
  metadata {
    name      = var.role_name
    namespace = var.target_namespace
    labels    = var.shared_labels
  }

  # Core API resources - pods, services, configmaps
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "persistentvolumeclaims", "persistentvolumes"]
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

resource "kubernetes_role_binding" "gha_target_ns_binding" {
  metadata {
    name      = "sa-${var.gha_service_account_name}-${var.gha_service_account_namespace}-binding"
    namespace = var.target_namespace
    labels    = var.shared_labels
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
