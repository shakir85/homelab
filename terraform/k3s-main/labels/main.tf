module "k3s-main-labels" {
  source = "../../modules/node-labels"

  node_label_map = {
    "k3s-main-node-1" = {
      "size" = "small"
    }
    "k3s-main-node-2" = {
      "size" = "medium"
    }
    "k3s-main-node-3" = {
      "size" = "medium"
    }
    "k3s-main-node-4" = {
      "size" = "large"
    }
  }
}
