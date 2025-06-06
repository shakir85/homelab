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
