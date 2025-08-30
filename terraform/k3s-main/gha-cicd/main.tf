module "cicd_namespace" {
  source = "../../modules/namespace"
  name   = var.kube_namespace
  labels = var.shared_labels
}

resource "kubernetes_service_account" "gha_runner" {
  metadata {
    name      = "gha-runner"
    namespace = var.kube_namespace
    labels    = var.shared_labels
  }
}

# Generate a toke for the service account 'gha_runner' in
# namespace 'var.kube_namespace' to be used in the kubeconfig (see outputs.tf)
resource "kubernetes_secret_v1" "gha_token" {
  metadata {
    name      = "gha-runner-token"
    namespace = var.kube_namespace
    labels    = var.shared_labels
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.gha_runner.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

# Create role and role binding for the 'gha_runner' service account
# in the namespace 'var.kube_namespace'
module "rbac_gha" {
  source = "../../modules/k8s-roles"

  role_name                 = "gha-helm-deployer"
  namespace                 = var.kube_namespace
  service_account_namespace = var.kube_namespace
  service_account_name      = kubernetes_service_account.gha_runner.metadata[0].name
}

# Add additional roles and role bindings for service-account 'gha_runner'
# in namespaces that the runner should be able to deploy to?
# Use one module call per namespace. namespace must be created first!
module "rbac_apps" {
  source = "../../modules/k8s-roles"

  role_name                 = "gha-helm-deployer"
  namespace                 = "apps"
  service_account_namespace = var.kube_namespace
  service_account_name      = kubernetes_service_account.gha_runner.metadata[0].name
}

# Helm needs access to namespaces
module "gha_cluster_access" {
  source                    = "../../modules/k8s-cluster-roles"
  service_account_namespace = var.kube_namespace
  service_account_name      = kubernetes_service_account.gha_runner.metadata[0].name
  role_name                 = "gha-read-namespaces"
}
