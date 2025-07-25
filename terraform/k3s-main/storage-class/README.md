<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (~> 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (~> 2.36.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [kubernetes_storage_class.nfs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) (resource)

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

## Outputs

No outputs.
<!-- END_TF_DOCS -->
