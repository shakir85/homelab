output "gha_kubeconfig_snippet" {
  description = "Kubeconfig section for GitHub Actions"
  sensitive   = true
  value       = <<EOF
apiVersion: v1
kind: Config
clusters:
- name: k3s-main
  cluster:
    server: "https://${var.k3s_main_control_plane_ipv4}:6443"
    certificate-authority-data: ${base64encode(kubernetes_secret_v1.gha_token.data["ca.crt"])}
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

output "kube_context_in_use" {
  value       = var.kube_context
  description = "The kubeconfig context being used by the Kubernetes provider"
}
