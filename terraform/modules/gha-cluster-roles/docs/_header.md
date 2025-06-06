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
