Custom values for Nginx Ingress Controller Helm chart with:
  - Disabled `controller.service.ports.https` (to terminate TLS outside Ingress).
  - Set `controller.kind` as `DaemonSet` instead of `Deployment`.
  - Disabled Nginx self-signed cert in `controller.extraArgs.default-ssl-certificate`.
