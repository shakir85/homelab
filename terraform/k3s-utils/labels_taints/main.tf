module "k3s-utils-size-labels" {
  source = "../../modules/node-labels"

  node_label_map = {
    "k3s-utils-node-1" = {
      (var.size_label_key) = "medium"
    }
    "k3s-utils-node-2" = {
      (var.size_label_key) = "medium"
    }
    "k3s-utils-node-3" = {
      (var.size_label_key) = "medium"
    }
    "k3s-utils-tc-1" = {
      (var.size_label_key) = "x-large"
    }
  }
}

module "k3s-utils-name-labels" {
  source = "../../modules/node-labels"

  node_label_map = {
    "k3s-utils-node-1" = {
      (var.name_label_key) = "k3s-utils-node-1"
    }
    "k3s-utils-node-2" = {
      (var.name_label_key) = "k3s-utils-node-2"
    }
    "k3s-utils-node-3" = {
      (var.name_label_key) = "k3s-utils-node-3"
    }
    "k3s-utils-tc-1" = {
      (var.name_label_key) = "k3s-utils-tc-1"
    }
  }
}

resource "null_resource" "taint_node_k3s_utils_tc_1" {
  provisioner "local-exec" {
    command = <<-EOT
      kubectl taint node k3s-utils-tc-1 dedicated=monitoring:NoSchedule --overwrite
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}
