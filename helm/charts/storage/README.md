# PVC Helm Module

This Helm module provisions a *single* PersistentVolumeClaim (PVC) and supports mounting it to *multiple paths* within a container using `subPath`.

## What can this chart do?

Creates **only one PVC** regardless of how many mount paths are defined, with:
- Custom access modes
- Storage class configuration
- Labels and annotations
- Shared volumes (e.g., NFS)

## Values Structure (PVC Chart)

```yaml
pvc:
  enabled: true
  claimName: claim-myapp
  accessMode: ReadWriteMany
  storageClassName: nfs-client
  storage: 5Gi
  mountPaths:
    - /data
    - /config
  labels:
    app: myapp
  annotations:
    volume.kubernetes.io/description: "Shared PVC for my app"
```

## Template Highlights

PVC Manifest
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Values.pvc.claimName }}
spec:
  accessModes:
    - {{ .Values.pvc.accessMode | default "ReadWriteMany" }}
  resources:
    requests:
      storage: {{ .Values.pvc.storage | default "1Gi" }}
  storageClassName: {{ .Values.pvc.storageClassName | default "nfs-client" }}
```

Deployment Integration (Mounts the same PVC to different paths using `subPath`):

```yaml
volumeMounts:
  {{- $claimName := .Values.pvc.claimName }}
  {{- range .Values.pvc.mountPaths }}
  - name: {{ $claimName }}
    mountPath: {{ . }}
    subPath: {{ trimPrefix "/" . }}
  {{- end }}

volumes:
  - name: {{ .Values.pvc.claimName }}
    persistentVolumeClaim:
      claimName: {{ .Values.pvc.claimName }}
```

## Caveats

- `subPath` must be explicitly used to prevent all mount paths from sharing the same PVC root.
- Subdirectories (data, config, etc.) are created inside the PVC volume automatically on first write, or can be pre-created using an `initContainer`.

## Benefits

- Efficient use of resources: single PVC shared across multiple application paths.
- Cleaner directory separation within shared volume backends (e.g., NFS).
- Customizable via Helm values.
