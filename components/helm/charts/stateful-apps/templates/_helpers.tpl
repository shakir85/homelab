{{/* Define the base name */}}
{{- define "stateful-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Define the full name */}}
{{- define "stateful-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" (include "stateful-app.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/* Define common metadata labels */}}
{{- define "stateful-app.labels" -}}
app.kubernetes.io/name: {{ include "stateful-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . }}
{{- end }}
{{- end }}

{{/*
Define common selector labels with dynamic role.
Usage: include "stateful-app.selectorLabels" (dict "role" "app" "context" .)
*/}}
{{- define "stateful-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stateful-app.name" .context }}
app.kubernetes.io/role: {{ .role }}
{{- end }}

{{/* Define db hostname, using the configured value if provided */}}
{{- define "stateful-app.db" -}}
{{- if .Values.db.host -}}
{{ .Values.db.host }}
{{- else -}}
{{ printf "%s-db" (include "stateful-app.name" .) }}
{{- end -}}
{{- end }}

{{/* Returns the db headless service name */}}
{{- define "stateful-app.dbHeadlessServiceName" -}}
{{ include "stateful-app.name" . }}-db-headless
{{- end }}

{{/* Returns the db service name */}}
{{- define "stateful-app.dbServiceName" -}}
{{- if .Values.db.serviceName -}}
{{ .Values.db.serviceName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{ include "stateful-app.name" . }}-db
{{- end -}}
{{- end }}
