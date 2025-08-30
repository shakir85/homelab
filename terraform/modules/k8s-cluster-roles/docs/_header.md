## Usage


This module creates a K8s ClusterRole for ServiceAccount, granting read and create permissions for tools that need cluster wide access.

## Example

```hcl
module "gha_namespace_reader" {
  source                     = "./modules/namespace-reader"
  gha_service_account_name    = "github-actions"
  gha_service_account_namespace = "cicd"
}
```
