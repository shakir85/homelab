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
  }
}
