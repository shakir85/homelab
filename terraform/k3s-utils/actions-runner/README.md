<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (~> 2.9.0)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (~> 2.9.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.gha_runners](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_gha_runner_name"></a> [gha\_runner\_name](#input\_gha\_runner\_name)

Description: Name of the GHA runners

Type: `string`

Default: `"tf-runners-k3s"`

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-utils-ctx"`

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: Namespace where the runners will be deployed

Type: `string`

Default: `"actions"`

### <a name="input_runner_name"></a> [runner\_name](#input\_runner\_name)

Description: GHA runner name

Type: `string`

Default: `"tf-managed"`

### <a name="input_runner_type"></a> [runner\_type](#input\_runner\_type)

Description: GHA runner type. See chart's notes for more info

Type: `string`

Default: `"deployRunnerDeployment"`

## Outputs

The following outputs are exported:

### <a name="output_kube_context_in_use"></a> [kube\_context\_in\_use](#output\_kube\_context\_in\_use)

Description: The kubeconfig context being used by the Kubernetes provider
<!-- END_TF_DOCS -->
