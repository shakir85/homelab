resource "kubernetes_namespace" "cicd" {
  metadata {
    name = var.kube_namespace
  }
}

resource "kubernetes_service_account" "gha_runner" {
  metadata {
    name      = "gha-runner"
    namespace = kubernetes_namespace.cicd.metadata[0].name
  }
}

resource "kubernetes_role" "gha_runner" {
  metadata {
    name      = "gha-runner"
    namespace = kubernetes_namespace.cicd.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services"]
    verbs      = ["get", "list", "create", "delete"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list", "create", "delete", "patch"]
  }
}

resource "kubernetes_role_binding" "gha_runner" {
  metadata {
    name      = "gha-runner-binding"
    namespace = kubernetes_namespace.cicd.metadata[0].name
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.gha_runner.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.gha_runner.metadata[0].name
    namespace = kubernetes_namespace.cicd.metadata[0].name
  }
}

resource "kubernetes_secret_v1" "gha_token" {
  metadata {
    name      = "gha-runner-token"
    namespace = kubernetes_namespace.cicd.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.gha_runner.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

output "gha_kubeconfig_snippet" {
  description = "Kubeconfig section for GitHub Actions"
  sensitive   = true
  value       = <<EOF
apiVersion: v1
kind: Config
clusters:
- name: k3s-main
  cluster:
    server: "https://${var.control_plane_ipv4}:6443"
    certificate-authority-data: ${kubernetes_secret_v1.gha_token.data["ca.crt"]}
users:
- name: gha-runner
  user:
    token: ${kubernetes_secret_v1.gha_token.data.token}
contexts:
- name: gha-context
  context:
    cluster: k3s-main
    user: gha-runner
    namespace: cicd
current-context: gha-context
EOF
}
