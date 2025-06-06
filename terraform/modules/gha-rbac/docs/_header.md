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

