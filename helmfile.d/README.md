# Helmfile Configuration

This directory contains the declarative [Helmfile](https://github.com/helmfile/helmfile) setup for deploying applications and persistent storage (PVCs) to the Kubernetes cluster.

## Structure

- `helmfile.yaml`: Top-level Helmfile that orchestrates all app and PVC helm releases defined in `*.yaml.gotmpl` templates.
<!-- `_common.gotmpl`: Go template defining reusable variables (e.g., chart paths, values directory, namespace). -->
- `apps-helmfile.yaml.gotmpl`: Helmfile, constructed as a Go template, for app deployments.
- `storage-helmfile.yaml.gotmpl`: Helmfile, constructed as a Go template, for storage deployments.

