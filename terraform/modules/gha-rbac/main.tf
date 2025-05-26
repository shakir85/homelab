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
 *
 * ## Least Privilege Implementation
 *
 * This module is designed with the principle of leat privilege in mind. And it's mainly to allow
 * Helm to install, upgrade, and uninstall charts. Charts in this repo deploy only services,
 * ingress, pvc, and deployment, and Helm typically needs RBAC to:
 *
 *   - get, create, update, patch, delete — for managing resources like Deployments, Services, PVCs, etc.
 *   - list — for internal release tracking (e.g. existing resources or Helm Secrets).
 *   - watch — not required for Helm CLI itself, but I will keep it for controllers.
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

  # Core API resources - pods, services, configmaps
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "persistentvolumeclaims"]
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
