<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.36.0)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_k3s-main-name-labels"></a> [k3s-main-name-labels](#module\_k3s-main-name-labels)

Source: ../../modules/node-labels

Version:

### <a name="module_k3s-main-size-labels"></a> [k3s-main-size-labels](#module\_k3s-main-size-labels)

Source: ../../modules/node-labels

Version:

## Resources

No resources.

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-main-ctx"`

### <a name="input_name_label_key"></a> [name\_label\_key](#input\_name\_label\_key)

Description: The key for the name label

Type: `string`

Default: `"k3s.shakir.cloud/name"`

### <a name="input_size_label_key"></a> [size\_label\_key](#input\_size\_label\_key)

Description: The key for the size label

Type: `string`

Default: `"k3s.shakir.cloud/size"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->