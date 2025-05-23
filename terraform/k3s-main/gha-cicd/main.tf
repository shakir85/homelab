/**
 * ## Service Account Setup for GitHub Actions (GHA)
 *
 * This Terraform config provisions the required Kubernetes resources to enable GHA runners to deploy into one or more namespaces.
 * This pattern supports centralized CI/CD with a principle of least privilege.
 *
 * ### What This Does
 * - Creates the primary `cicd` namespace (via `modules/namespaces`).
 * - Provisions a `gha-runner` ServiceAccount in that namespace.
 * - Generates a ServiceAccount token (`kubernetes.io/service-account-token`) for kubeconfig injection (see `outputs.tf`).
 * - Grants the ServiceAccount RBAC permissions in the `cicd` namespace via the `gha-rbac` module.
 * - Optionally, extends RBAC to additional target namespaces (e.g., `foo`, `bar`) to allow GHA to deploy apps across multiple namespaces.
 *
 * ### Usage Notes
 * - Only one `gha-runner` account is created and reused across all target namespaces.
 * - For each namespace to deploy into, include an additional call to the `gha-rbac` module with the corresponding `target_namespace`.
 * - The generated kubeconfig (via output) can be injected into GHA workflows for scoped access or to allow cross-clusters deployments (i.e., cluster X -> deploys to -> cluster Y).
 *
 * ### Related Modules
 * - `modules/namespaces`: For creating namespaces with optional labels and annotations.
 * - `modules/gha-rbac`: Grants scoped permissions to the GHA service account across namespaces.
 *
 */
module "cicd_namespace" {
  source = "../../modules/namespaces"
  name   = var.kube_namespace
}

resource "kubernetes_service_account" "gha_runner" {
  metadata {
    name      = "gha-runner"
    namespace = var.kube_namespace
  }
}

# Generate a toke for the service account 'gha_runner' in
# namespace 'var.kube_namespace' to be used in the kubeconfig (see outputs.tf)
resource "kubernetes_secret_v1" "gha_token" {
  metadata {
    name      = "gha-runner-token"
    namespace = var.kube_namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.gha_runner.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

# Create role and role binding for the 'gha_runner' service account
# in the namespace 'var.kube_namespace'
module "rbac_gha" {
  source                        = "../../modules/gha-rbac"
  target_namespace              = var.kube_namespace
  gha_service_account_namespace = var.kube_namespace
  gha_service_account_name      = kubernetes_service_account.gha_runner.metadata[0].name
}

# Add additional roles and role bindings for service-account 'gha_runner'
# in namespaces that the runner should be able to deploy to?
# Use one module call per namespace. namespace must be created first!
module "rbac_apps" {
  source                        = "../../modules/gha-rbac"
  target_namespace              = "apps"
  gha_service_account_namespace = var.kube_namespace
  gha_service_account_name      = kubernetes_service_account.gha_runner.metadata[0].name
}
