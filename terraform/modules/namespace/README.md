<!-- BEGIN_TF_DOCS -->
## Usage

This is an example of how to use this module to provision a namespace with optional labels and annotations.

```hcl
module "example_namespace" {
  source = "path/to/this/module"

  # Required
  name = "example"

  # Optional
  labels = {
    "env" = "dev"
  }

  annotations = {
    "owner" = "dev-team"
  }
}
```

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (>= 2.36.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the namespace

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_annotations"></a> [annotations](#input\_annotations)

Description: Map of annotations to apply to the namespace

Type: `map(string)`

Default: `{}`

### <a name="input_labels"></a> [labels](#input\_labels)

Description: Map of labels to apply to the namespace

Type: `map(string)`

Default: `{}`

## Outputs

No outputs.
<!-- END_TF_DOCS -->