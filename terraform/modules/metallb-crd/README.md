<!-- BEGIN_TF_DOCS -->
## MetalLB Custom Resource Definitions (CRDs) Deployment

This module installs the official MetalLB CRDs for Layer 2 advertisement with a static IP address pool using Terraform.

## Requirements
Set IP address ranges for MetalLB to allocate when a LoadBalancer Service is deployed;
ensure the range is available in your router - e.g., 192.168.50.90-192.168.50.99 may be reserved
for static mapping.

This will:
- Deploy a `IPAddressPool` CRD
- Deploy a `L2Advertisement` CRD that references the IP pool

> Note: MetalLB must be up and running **before** running this configuration.

## Example

```hcl
module "metallb_crds" {
  source                  = "./modules/metallb-crds"
  kube_namespace          = "metallb-system"
  ipv4_address_pool_name  = "default-ip-pool"
  ipv4_address_pool       = ["192.168.50.90-192.168.50.99"]
  shared_labels           = {
    app = "metallb"
  }
}
```

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

- [kubernetes_manifest.ip_address_pool](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) (resource)
- [kubernetes_manifest.l2_advertisement](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_ipv4_address_pool"></a> [ipv4\_address\_pool](#input\_ipv4\_address\_pool)

Description: To generate an address pool. An *address pool* is one or more IPv4 range. This variable is a list of strings for the IPv4 *ranges* that MetalLB will use when provisioning a Service of type LoadBalance. Example values: `['192.168.50.90-192.168.50.99', '192.168.20.45-192.168.20.60']`

Type: `list(string)`

Default:

```json
[
  "10.10.50.90-10.10.50.99"
]
```

### <a name="input_ipv4_address_pool_name"></a> [ipv4\_address\_pool\_name](#input\_ipv4\_address\_pool\_name)

Description: IP addresses pool name. This name will be used in the `L2Advertisement.spec.IPAddressPool` K8s CRD. This is important because if omitted, MetalLB will advertise from any available IP pool in the namespace.

Type: `string`

Default: `"default-pool"`

### <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path)

Description: Path to kubeconfig file relative to where this script will run

Type: `string`

Default: `"~/.kube/config"`

### <a name="input_kube_context"></a> [kube\_context](#input\_kube\_context)

Description: The name of the kubeconfig context to use

Type: `string`

Default: `"k3s-main-ctx"`

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: Namespace where the gha-runner service account will reside (typically 'cicd')

Type: `string`

Default: `"metallb-system"`

### <a name="input_shared_labels"></a> [shared\_labels](#input\_shared\_labels)

Description: Shared labels

Type: `map(string)`

Default:

```json
{
  "app.kubernetes.io/managed-by": "terraform"
}
```

## Outputs

The following outputs are exported:

### <a name="output_kube_context_in_use"></a> [kube\_context\_in\_use](#output\_kube\_context\_in\_use)

Description: The kubeconfig context being used by the Kubernetes provider
<!-- END_TF_DOCS -->
