<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_null"></a> [null](#requirement\_null) (~> 3.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_null"></a> [null](#provider\_null) (~> 3.0.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [null_resource.label_nodes](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_node_label_map"></a> [node\_label\_map](#input\_node\_label\_map)

Description: Map of node names to label key-values

Type: `map(map(string))`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_node_labels"></a> [node\_labels](#output\_node\_labels)

Description: Map of node names to label key-values
<!-- END_TF_DOCS -->
