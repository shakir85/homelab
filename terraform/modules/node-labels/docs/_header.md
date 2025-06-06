## Module: Kubernetes Node Labeler

This Terraform module applies Kubernetes labels to nodes using `kubectl`.

It uses a `null_resource` and a `local-exec` provisioner to run `kubectl label` commands for each node-label pair defined in `var.node_label_map`.

### Inputs

- `node_label_map`: A map of node names to key-value label pairs.  
  Example:
  ```hcl
  node_label_map = {
    "node-1" = {
      "role"  = "worker"
      "zone"  = "us-central1-a"
    },
    "node-2" = {
      "role" = "gpu"
    }
  }

## Behavior

For each node and its labels, the module runs:
```sh
kubectl label node <node> <key>=<value> --overwrite
```

>[!Note]
> This module just implements an `exec` provisioner. It requires the `kubectl` executable to be installed at apply time.
