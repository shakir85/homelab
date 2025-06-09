
Stateless Apps Helm Chart
*************************

A generic and reusable Helm chart for deploying lightweight, stateless web-apps that share common configuration patterns such as services, ingress routing, and optional NFS volume mounts.

## What this chart can do

-	Deployment resource with basic `replicaCount` spec.
- Custome environment variables via top-level key `env`.
-	A service with `service.port` and container port `service.targetPort`.
-	Optional, ingress resource with configurable host and class.
-	Optional, PVC resource with multiple mount points inside the pod via the `pvc.mountPaths` list.
- Optional, `lievenessProbe` and `affinity` rule.


## Example values.yml
```yaml
app:
  name: "example"
  image:
    repository: foo/example"
    tag: "1.1"
    pullPolicy: IfNotPresent

replicaCount: 1

service:
  port: 80
  targetPort: 5916

ingress:
  enabled: true
  host: "example.internal"
  ingressClassName: nginx

livenessProbe:
  enabled: true
  command: ["example", "src/health.sh"]
  initialDelaySeconds: 20
  periodSeconds: 60
  timeoutSeconds: 10
  failureThreshold: 3

pvc:
  enabled: true
  claimName: example-ready-claim
  mountPaths:
    - /data
    - /config
    - /src
```
