# Stateful Apps Helm Chart

A lightweight Helm chart for deploying a stateful application composed of two main components:

- `app` – A stateless frontend/backend component deployed as a Deployment
- `db` – A stateful database component deployed as a StatefulSet

This setup is designed for Kubernetes environments with PVC (e.g., NFS-backed PVCs), that share the same backend volume with separate subpaths mounted as sub-directories in the storage backend.

## Details
- The `app` and `db` workloads are separate with specific deployment boundaries:
  - The `app` is a K8s Deployment with Service to serve traffic and ingress for external access.
  - The `db` is a K8s Statefulset with a Headless Service which allow the app to connect to the DB via stable DNS hostname.

| Component | Type         | Purpose                                |
|-----------|--------------|----------------------------------------|
| `app`     | Deployment   | The core application logic            |
| `db`      | StatefulSet  | Database                              |
| `Service` | ClusterIP    | Internal service for app access        |
| `Ingress` | Ingress      | External app access (optional)         |
| `Headless Service` | ClusterIP (None) | For DB DNS resolution        |



>[!Note] Persistent Volume Claim (PVC) This chart does not create the PersistentVolumeClaim (PVC) itself. Storage is treated as a *separate lifecycle concern* from applications.
