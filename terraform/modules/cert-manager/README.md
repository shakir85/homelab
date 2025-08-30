<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (~> 2.9.0)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (~> 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (~> 2.9.0)

## Modules

The following Modules are called:

### <a name="module_cert_manager_namespace"></a> [cert\_manager\_namespace](#module\_cert\_manager\_namespace)

Source: ../../modules/namespace

Version:

## Resources

The following resources are used by this module:

- [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version)

Description: Cert manager version

Type: `string`

Default: `"1.17.2"`

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-utils-ctx"`

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: Namespace where the cert-manager will be deployed

Type: `string`

Default: `"cert-manager"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->
