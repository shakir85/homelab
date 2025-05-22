/**
* Name of the created namespace.
*/
output "name" {
  description = "The name of the created namespace"
  value       = kubernetes_namespace.this.metadata[0].name
}
