<!-- BEGIN_TF_DOCS -->
## Service Account Setup for GitHub Actions (GHA)

This Terraform config provisions the required Kubernetes resources to enable GHA runners to deploy into one or more namespaces.
This pattern supports centralized CI/CD with a principle of least privilege.

### What This Does
- Creates the primary `cicd` namespace (via `modules/namespaces`).
- Provisions a `gha-runner` ServiceAccount in that namespace.
- Generates a ServiceAccount token (`kubernetes.io/service-account-token`) for kubeconfig injection (see `outputs.tf`).
- Grants the ServiceAccount RBAC permissions in the `cicd` namespace via the `gha-rbac` module.
- Optionally, extends RBAC to additional target namespaces (e.g., `foo`, `bar`) to allow GHA to deploy apps across multiple namespaces.

### Usage Notes
- Only one `gha-runner` account is created and reused across all target namespaces.
- For each namespace to deploy into, include an additional call to the `gha-rbac` module with the corresponding `target_namespace`.
- The generated kubeconfig (via output) can be injected into GHA workflows for scoped access or to allow cross-clusters deployments (i.e., cluster X -> deploys to -> cluster Y).

### Related Modules
- `modules/namespaces`: For creating namespaces with optional labels and annotations.
- `modules/gha-rbac`: Grants scoped permissions to the GHA service account across namespaces.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.36.0)

## Providers

The following providers are used by this module:

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (>= 2.36.0)

## Modules

The following Modules are called:

### <a name="module_cicd_namespace"></a> [cicd\_namespace](#module\_cicd\_namespace)

Source: ../../modules/namespace

Version:

### <a name="module_gha_cluster_access"></a> [gha\_cluster\_access](#module\_gha\_cluster\_access)

Source: ../../modules/gha-cluster-roles

Version:

### <a name="module_rbac_apps"></a> [rbac\_apps](#module\_rbac\_apps)

Source: ../../modules/gha-rbac

Version:

### <a name="module_rbac_gha"></a> [rbac\_gha](#module\_rbac\_gha)

Source: ../../modules/gha-rbac

Version:

## Resources

The following resources are used by this module:

- [kubernetes_secret_v1.gha_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) (resource)
- [kubernetes_service_account.gha_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_k3s_main_control_plane_ipv4"></a> [k3s\_main\_control\_plane\_ipv4](#input\_k3s\_main\_control\_plane\_ipv4)

Description: Control plane IP or DNS

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

Default: `"k3s-main-ctx"`

### <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace)

Description: Namespace where the gha-runner service account will reside (typically 'cicd')

Type: `string`

Default: `"cicd"`

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

### <a name="output_gha_kubeconfig_snippet"></a> [gha\_kubeconfig\_snippet](#output\_gha\_kubeconfig\_snippet)

Description: Kubeconfig section for GitHub Actions

### <a name="output_kube_context_in_use"></a> [kube\_context\_in\_use](#output\_kube\_context\_in\_use)

Description: The kubeconfig context being used by the Kubernetes provider
<!-- END_TF_DOCS -->