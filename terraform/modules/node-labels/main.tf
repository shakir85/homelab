terraform {
  required_version = "~> 1.13.1"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0.0"
    }
  }
}
resource "null_resource" "label_nodes" {
  for_each = var.node_label_map

  provisioner "local-exec" {
    command = join(" && ", [
      for k, v in each.value :
      "kubectl label node ${each.key} ${k}=${v} --overwrite"
    ])
  }

  triggers = {
    node      = each.key
    label_str = join(",", [for k, v in each.value : "${k}=${v}"])
  }
}

output "node_labels" {
  description = "Map of node names to label key-values"
  value       = var.node_label_map
}
