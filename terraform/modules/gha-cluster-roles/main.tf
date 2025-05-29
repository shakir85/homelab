/**
 * ## Usage
 *
 * This module creates a Kubernetes ClusterRole and ClusterRoleBinding granting read and create
 * permissions on namespaces. It is useful when Helm or other tools need to verify or create
 * namespaces before installing resources.
 *
 * The ClusterRole allows `get`, `list`, and `create` verbs on the `namespaces` resource.
 * The ClusterRoleBinding binds this role to a specified ServiceAccount, typically your GitHub Actions runner or CI account.
 *
 * ## Example
 *
 * ```hcl
 * module "gha_namespace_reader" {
 *   source                     = "./modules/namespace-reader"
 *   gha_service_account_name    = "github-actions"
 *   gha_service_account_namespace = "cicd"
 * }
 * ```
 */
 terraform {
  required_version = ">= 1.5.7"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
  }
}

resource "kubernetes_cluster_role" "gha_namespace_reader" {
  metadata {
    name = "gha-read-namespaces"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get", "list", "create"]
  }
}

resource "kubernetes_cluster_role_binding" "gha_namespace_reader_binding" {
  metadata {
    name = "gha-read-namespaces-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.gha_namespace_reader.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.gha_service_account_name
    namespace = var.gha_service_account_namespace
  }
}
