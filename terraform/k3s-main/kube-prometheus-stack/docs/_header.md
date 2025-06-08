# Prometheus Stack Helm Deployment

This Terraform module deploys the `kube-prometheus-stack` Helm chart from the [prometheus-community](https://github.com/prometheus-community/helm-charts) repository into a Kubernetes cluster, under the `monitoring` namespace.

The module sets up Prometheus, Grafana, Alertmanager, and associated monitoring components using a **base `values.yaml` file** located in the module directory. This `values.yaml` contains minimal, working defaults intended as a foundation for cluster-wide monitoring.


For any additional configuration such as Alertmanager notification routes (e.g., Slack, Discord, ntfy), custom scrape configs
or dashboards, you should override or extend these settings by passing them through the `values` argument in Terraform:

```hcl
values = [
  file("${path.module}/values.yaml"), # defaults go here
  file("${path.module}/custom-values.yaml")  # optional overrides
]
```
