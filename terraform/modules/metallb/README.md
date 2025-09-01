<!-- BEGIN_TF_DOCS -->
## MetalLB Helm Deployment

This module installs the official [MetalLB Helm chart](https://metallb.universe.tf/installation/#installation-with-helm)

## Usage

```hcl
module "metallb" {
  source  = "path/to/this/module"
}
```

This will:
- Install the MetalLB Helm chart version specified in `var.metallb_version` in the `metallb-system` namespace

> Note: If you plan to install MetalLB Custom Resource Definition (CRDs) for IP advertisement, they must be created **after** the Helm chart installation.

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

- [helm_release.metallb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: Namespace where MetlLb should be installed. Default to `metallb-system` (this is a standard MetalLb namespace, don't change if you don't know what you're doing!)

Type: `string`

Default: `"metallb-system"`

### <a name="input_metallb_version"></a> [metallb\_version](#input\_metallb\_version)

Description: MetlLb version

Type: `string`

Default: `"0.14.5"`

### <a name="input_release_name"></a> [release\_name](#input\_release\_name)

Description: Helm release name

Type: `string`

Default: `"metallb"`

## Outputs

The following outputs are exported:

### <a name="output_metallb_chart_status"></a> [metallb\_chart\_status](#output\_metallb\_chart\_status)

Description: n/a
<!-- END_TF_DOCS -->
