{{/* Go template - helmfile - for platform tools deployment */}}

{{- /* Variable definitions */ -}}
{{- $valuesDir := "../helm/values/platform" -}}
{{- $chartsDir := "../helm/charts" -}}

repositories:
  - name: cert-manager
    url: https://charts.jetstack.io
  - name: csi-driver-nfs
    url: https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts

releases:
  - name: cert-manager
    chart: jetstack/cert-manager
    version: 1.17.2
    namespace: cert-manager
    createNamespace: true
    values:
      - {{ printf "%s/%s" $valuesDir "cert-manager-v1.17.2.yaml" }}

  - name: csi-driver-nfs
    chart: csi-driver-nfs/csi-driver-nfs
    version: 4.11.0
    namespace: kube-system
    values:
      - {{ printf "%s/%s" $valuesDir "csi-driver-nfs-v4.11.0.yaml" }}

  - name: ingress-nginx
    chart: ingress-nginx/ingress-nginx
    version: 4.10.0
    namespace: ingress-nginx
    values:
      - {{ printf "%s/%s" $valuesDir "ingress-nginx-v4.10.0.yaml" }}

  - name: metallb
    chart: metallb/metallb
    version: 0.14.5
    namespace: metallb-system
    createNamespace: true
    values:
      - {{ printf "%s/%s" $valuesDir "metallb-v0.14.5.yaml" }}

  - name: metallb-crd
    needs: metallb
    chart: {{ printf "%s/%s" $chartsDir "metallb-crd" }}
    values:
      - {{ printf "%s/%s" $valuesDir "metallb-crd.yaml" }}
