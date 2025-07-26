<!-- BEGIN_TF_DOCS -->
## Usage

This module creates a `Role` and `RoleBinding` to allow a GitHub Actions runner service account
in one namespace (usually `cicd`) to perform necessary operations in a target namespace.

It is intended to be used when GitHub Actions Runners deployed in a dedicated namespace
need permission to deploy applications into other namespaces.

Example:

```hcl
module "rbac_app_namespace" {
  source                        = "git::https://github.com/<your-org>/terraform-modules.git//gha-rbac?ref=<RELEASE_ID>"
  target_namespace              = "my-app"
  gha_service_account_namespace = "cicd"
  gha_service_account_name      = "gha-runner"
  role_name                     = "gha-runner"
}
```

This creates:
- A Role in the `target_namespace` with permissions to manage the type of k8s resources defined in the `kubernetes_role` block.
- A RoleBinding to bind the remote service account (`gha-runner` in `cicd`) to that `kubernetes_role` role.

## Least Privilege Implementation

This module is designed with the principle of leat privilege in mind. And it's mainly to allow
Helm to install, upgrade, and uninstall charts. Charts in this repo deploy only services,
ingress, pvc, and deployment, and Helm typically needs RBAC to:

  - get, create, update, patch, delete — for managing resources like Deployments, Services, PVCs, etc.
  - list — for internal release tracking (e.g. existing resources or Helm Secrets).
  - watch — not required for Helm CLI itself, but I will keep it for controllers.

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

- [kubernetes_role.gha_target_ns_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) (resource)
- [kubernetes_role_binding.gha_target_ns_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_gha_service_account_name"></a> [gha\_service\_account\_name](#input\_gha\_service\_account\_name)

Description: The name of the ServiceAccount in the CI/CD namespace

Type: `string`

### <a name="input_gha_service_account_namespace"></a> [gha\_service\_account\_namespace](#input\_gha\_service\_account\_namespace)

Description: Namespace where the CI/CD ServiceAccount resides

Type: `string`

### <a name="input_target_namespace"></a> [target\_namespace](#input\_target\_namespace)

Description: Namespace where the Helm deployment will be performed

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_role_name"></a> [role\_name](#input\_role\_name)

Description: Name of the Role to create in the target namespace

Type: `string`

Default: `"gha-helm-deployer"`

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

No outputs.
<!-- END_TF_DOCS -->
