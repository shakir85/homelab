module "k3s-main-size-labels" {
  source = "../../modules/node-labels"

  node_label_map = {
    "k3s-main-node-1" = {
      (var.size_label_key) = "small"
    }
    "k3s-main-node-2" = {
      (var.size_label_key) = "medium"
    }
    "k3s-main-node-3" = {
      (var.size_label_key) = "medium"
    }
    "k3s-main-node-4" = {
      (var.size_label_key) = "large"
    }
    "k3s-main-nuc-1" = {
      (var.size_label_key) = "small"
    }
    "k3s-main-nuc-2" = {
      (var.size_label_key) = "small"
    }
    "k3s-main-nuc-3" = {
      (var.size_label_key) = "x-large"
    }
    "k3s-main-tc-1" = {
      (var.size_label_key) = "x-large"
    }
  }
}

module "k3s-main-name-labels" {
  source = "../../modules/node-labels"

  node_label_map = {
    "k3s-main-node-1" = {
      (var.name_label_key) = "k3s-main-node-1"
    }
    "k3s-main-node-2" = {
      (var.name_label_key) = "k3s-main-node-2"
    }
    "k3s-main-node-3" = {
      (var.name_label_key) = "k3s-main-node-3"
    }
    "k3s-main-node-4" = {
      (var.name_label_key) = "k3s-main-node-4"
    }
    "k3s-main-nuc-1" = {
      (var.name_label_key) = "k3s-main-nuc-1"
    }
    "k3s-main-nuc-2" = {
      (var.name_label_key) = "k3s-main-nuc-2"
    }
    "k3s-main-nuc-3" = {
      (var.name_label_key) = "k3s-main-nuc-3"
    }
    "k3s-main-tc-1" = {
      (var.name_label_key) = "k3s-main-tc-1"
    }
  }
}
