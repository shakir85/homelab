/**
 * ## Usage
 *
 * This module creates a `Role` and `RoleBinding` to allow a GitHub Actions runner service account
 * in one namespace (usually `cicd`) to perform necessary operations in a target namespace.
 *
 * It is intended to be used when GitHub Actions Runners deployed in a dedicated namespace
 * need permission to deploy applications into other namespaces.
 *
 * Example:
 *
 * ```hcl
 * module "rbac_app_namespace" {
 *   source                        = "git::https://github.com/<your-org>/terraform-modules.git//gha-rbac?ref=<RELEASE_ID>"
 *   target_namespace              = "my-app"
 *   gha_service_account_namespace = "cicd"
 *   gha_service_account_name      = "gha-runner"
 *   role_name                     = "gha-runner"
 * }
 * ```
 *
 * This creates:
 * - A Role in the `target_namespace` with permissions to manage the type of k8s resources defined in the `kubernetes_role` block.
 * - A RoleBinding to bind the remote service account (`gha-runner` in `cicd`) to that `kubernetes_role` role.
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

resource "kubernetes_role" "gha_target_ns_role" {
  metadata {
    name      = var.role_name
    namespace = var.target_namespace
    labels    = var.shared_labels
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
