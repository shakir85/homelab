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
