# Github Actions - Actions Runner Controller

Module for deploying Actions Runner Controller.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (~> 2.9.0)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (~> 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (~> 2.9.0)

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (~> 2.36.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.actions_runner_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_secret_v1.controller_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id)

Description: GitHub App ID

Type: `string`

### <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id)

Description: GitHub App Installation ID

Type: `string`

### <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key)

Description: Path to the GitHub App private key file

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-utils-ctx"`

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: The name of the namespace where resource will be deployed

Type: `string`

Default: `"actions"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->
