# Generic module for deploying Helm charts

This documentation has two main sections: Values Injection Strategy and Usage.

## Value Injection Strategy
This module supports two ways of injecting values into the Helm chart values and set_values.
The Terraform apply will not fail if you use only one of the value injection methods (values or set_values).
Both are optional and can be used independently or together.

### 1. `values` (YAML heredoc blocks)
Use the `values` variable to pass Helm values as one or more YAML-formatted strings.
This is equivalent to `-f values.yaml` in the Helm CLI.

Example:

```hcl
values = [
  <<-EOT
    replicaCount: 2
    image:
      tag: latest
  EOT
]
```

Use this for complex, structured configurations such as nested maps, lists, or multi-line data.

### 2. `set_values` (Inline key=value)

Use the `set_values` variable to pass values via Helm's `--set` flag, where each value is a flat key-value pair.

Example:
```hcl
set_values = [
  { name = "replicaCount", value = "2" },
  { name = "image.tag", value = "latest" }
]
```

This is suitable for simple overrides and dynamic injection of values.

## Usage

Example of using the generic Helm release module to install a chart:

```hcl
module "nginx" {
  source  = "git::https://github.com/your-org/terraform-modules.git//helm-release?ref=<RELEASE_TAG>"
  name    = "nginx"
  namespace = "web"
  repository     = "https://charts.bitnami.com/bitnami"
  chart          = "nginx"
  chart_version  = "15.0.0"
  create_namespace = true
  values = {
    service.type = "ClusterIP"
  }
  values_file = "${path.module}/nginx-values.yaml"
}
```
