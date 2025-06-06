<!-- BEGIN_TF_DOCS -->
# Generic module for deploying Helm charts

This documentation has two main sections: Values Injection Strategy and Usage.

## Value Injection Strategy
This module supports two ways of injecting values into the Helm chart values and set\_values.
The Terraform apply will not fail if you use only one of the value injection methods (values or set\_values).
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

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (>= 2.9.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (>= 2.9.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_chart"></a> [chart](#input\_chart)

Description: Helm chart name to install (e.g., bitnami/nginx)

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the Helm release

Type: `string`

### <a name="input_namespace"></a> [namespace](#input\_namespace)

Description: Kubernetes namespace to deploy the Helm release into

Type: `string`

### <a name="input_repository"></a> [repository](#input\_repository)

Description: Helm repository URL to use

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version)

Description: Optional version of the Helm chart to install

Type: `string`

Default: `null`

### <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace)

Description: Create the namespace if it does not already exist

Type: `bool`

Default: `true`

### <a name="input_set_values"></a> [set\_values](#input\_set\_values)

Description: Optional list of Helm set values (key-value pairs).

Type:

```hcl
list(object({
    name  = string
    value = string
  }))
```

Default: `[]`

### <a name="input_values"></a> [values](#input\_values)

Description: List of inline YAML values passed to the Helm chart

Type: `list(string)`

Default: `[]`

### <a name="input_wait"></a> [wait](#input\_wait)

Description: Wait until all Helm chart resources are ready

Type: `bool`

Default: `true`

## Outputs

No outputs.
<!-- END_TF_DOCS -->