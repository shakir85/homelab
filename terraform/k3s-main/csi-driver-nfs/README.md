<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (>= 2.9.0)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (>= 2.9.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.csi_driver_nfs](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_csi_driver_nfs_version"></a> [csi\_driver\_nfs\_version](#input\_csi\_driver\_nfs\_version)

Description: Helm chart version for csi-driver-nfs

Type: `string`

Default: `"4.11.0"`

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-main-ctx"`

## Outputs

The following outputs are exported:

### <a name="output_kube_context_in_use"></a> [kube\_context\_in\_use](#output\_kube\_context\_in\_use)

Description: The kubeconfig context being used by the Kubernetes provider
<!-- END_TF_DOCS -->