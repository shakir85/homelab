<!-- BEGIN_TF_DOCS -->
## Usage

This module creates a Kubernetes ClusterRole and ClusterRoleBinding granting read and create
permissions on namespaces. It is useful when Helm or other tools need to verify or create
namespaces before installing resources.

The ClusterRole allows `get`, `list`, and `create` verbs on the `namespaces` resource.
The ClusterRoleBinding binds this role to a specified ServiceAccount, typically your GitHub Actions runner or CI account.

## Example

```hcl
module "gha_namespace_reader" {
  source                     = "./modules/namespace-reader"
  gha_service_account_name    = "github-actions"
  gha_service_account_namespace = "cicd"
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

- [kubernetes_cluster_role.gha_namespace_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) (resource)
- [kubernetes_cluster_role_binding.gha_namespace_reader_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_gha_service_account_name"></a> [gha\_service\_account\_name](#input\_gha\_service\_account\_name)

Description: The name of the ServiceAccount

Type: `string`

### <a name="input_gha_service_account_namespace"></a> [gha\_service\_account\_namespace](#input\_gha\_service\_account\_namespace)

Description: Namespace where the ServiceAccount resides

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
