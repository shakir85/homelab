## Terraform Module: nginx-ingress

Installs the NGINX Ingress Controller using the official Helm chart.

This module:
- Installs the controller as a DaemonSet.
- Removes the `controller.service.port.https` value from values.yaml. TLS is terminated outside the ingress.

## Usage

```hcl
module "nginx_ingress" {
  source  = "./nginx-ingress"
  name    = "nginx-ingress"
  namespace = "ingress-nginx"
  chart_version = "4.10.0"
  repository    = "https://kubernetes.github.io/ingress-nginx"
}
```
