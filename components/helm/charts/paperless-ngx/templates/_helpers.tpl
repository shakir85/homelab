{{/* Define common labels */}}
{{- define "paperless-ngx.labels" -}}
app.kubernetes.io/name: {{ include "paperless-ngx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Define chart name */}}
{{- define "paperless-ngx.name" -}}
paperless-ngx
{{- end }}

{{/* Generate the generate fully qualified resource names */}}
{{- define "paperless-ngx.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/* Return the full Redis hostname, using the configured value if set,
otherwise default to "<fullname>-redis". */}}
{{- define "paperless-ngx.redisHost" -}}
{{- if .Values.redis.host -}}
{{ .Values.redis.host }}
{{- else -}}
{{ printf "%s-redis" (include "paperless-ngx.fullname" .) }}
{{- end -}}
{{- end }}

{{/* Returns the Redis headless service name */}}
{{- define "paperless-ngx.redisHeadlessServiceName" -}}
{{ include "paperless-ngx.fullname" . }}-redis
{{- end }}
