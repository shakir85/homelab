## Usage

This module creates `Role` and `RoleBinding` to allow a service account in one namespace to perform necessary operations in a target namespace. For example, it gives GitHub Actions Runners deployed in a dedicated namespace (e.g., `cicd`)
the needed auth to deploy into another namespaces. This is intended to limit the permissions of utilites and tools to only what they need, nothing more.

Example:

```hcl
module "rbac_app_namespace" {
  source                    = "./this/module"
  namespace                 = "my-app"
  service_account_namespace = "cicd"
  service_account_name      = "gha-runner"
  role_name                 = "gha-runner"
}
```
This creates:

- A Role in the specified `namespace` with permissions to manage the type of k8s resources defined in the `kubernetes_role` block.
- A RoleBinding to bind the remote service account (e.g. a SA named `gha-runner` in the `cicd` namespace) to that `kubernetes_role` role.
