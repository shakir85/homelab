# Helmfile Configuration

This directory contains the declarative [Helmfile](https://github.com/helmfile/helmfile) setup for deploying applications and persistent storage (PVCs) to the Kubernetes cluster.

## Structure

- `helmfile.yaml`: Top-level Helmfile that orchestrates all app and PVC helm releases defined in `*.yaml.gotmpl` templates.
<!-- `_common.gotmpl`: Go template defining reusable variables (e.g., chart paths, values directory, namespace). -->
- `apps-helmfile.yaml.gotmpl`: Helmfile, constructed as a Go template, for app deployments.
- `storage-helmfile.yaml.gotmpl`: Helmfile, constructed as a Go template, for storage deployments.

## Assumptions

- All applications are deployed into a shared namespace (default: `apps`).
- PVCs are defined in separate releases to allow reuse and clean separation of concerns (i.e., storage/apps decoupling).

## Templating

Helmfile uses Go templates (`*.gotmpl`) to avoid hardcoding values like chart and values paths. Common variables are defined in the top of each `.gotmpl` file. I might consolidate those values into a `_common.gotmpl` file once I'm more comfortable with advanced Go templating.

## Usage

```sh
# Apply all releases.
# Run from the root of the repository to render and apply `helmfile.yaml.gotmpl`:
helmfile apply

# Destroy a specific release by label:
helmfile destroy -l name=<app-name>

# Destroy a specific release using a specific helmfile.
# Run from the root of the repository:
helmfile -f helmfile.d/foo.yaml.gotmpl destroy -l name=<app-name>
```
