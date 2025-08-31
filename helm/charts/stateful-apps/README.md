# Stateful Apps Helm Chart

A minimalist Helm chart for deploying a stateful application consisting of two main components:

- `app` – Deployment to serve frontend/backend component.
- `db` – A Statefulset for the database pod.

Both the app and DB share a single PVC using subPaths, keeping storage simple and unified. This minimalist approach treats the entire application’s data as one cohesive unit, unlike setups that separate storage lifecycles for the app and database. For example, 
```
.
└── NFS_DIRECTORY/
    └── K8s_STORAGE/
        └── FOO_APP/
            ├── data/...
            ├── app/...
            └── postgres/...
```


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



> [!Note]
>  This chart does not create the PersistentVolumeClaim (PVC) itself. It assumes that the PVC already exists.  Storage is treated as a *separate lifecycle concern* from applications.
