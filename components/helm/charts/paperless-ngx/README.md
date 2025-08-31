# Paperless-NGX Helm Chart

A minimalistic Helm chart for Paperless-Ngx with SQLite and Redis backend.  
This chart is designed for simplicity and ease of deployment.

This chart deploys:
- Paperless-Ngx web app
- Redis as a StatefulSet, with a headless Service to serve it
- Allows mounting a single PVC for Paperless data and Redis (PVC should be provisioned separately)
- Ingress resource for external access
- Optional initial admin user secret

For more info, see: [https://docs.paperless-ngx.com/](https://docs.paperless-ngx.com/)
