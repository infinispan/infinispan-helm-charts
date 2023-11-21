{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "infinispan-helm-charts.name" -}}
{{- default .Release.Name .Values.deploy.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "infinispan-helm-charts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Generated Secret Name
*/}}
{{- define "infinispan-helm-charts.secret" -}}
{{- if eq (.Values.deploy.security.secretName) "" }}
{{- printf "%s-generated-secret" (include "infinispan-helm-charts.name" .) }}
{{- else }}
{{- .Values.deploy.security.secretName }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "infinispan-helm-charts.labels" -}}
clusterName: {{ include "infinispan-helm-charts.name" . }}
helm.sh/chart: {{ include "infinispan-helm-charts.chart" . }}
meta.helm.sh/release-name: {{ include "infinispan-helm-charts.name" . }}
meta.helm.sh/release-namespace: {{ .Release.Namespace }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- range .Values.deploy.resourceLabels }}
{{ .key }}: {{ .value }}
{{- end }}
{{- end }}

{{/*
Pod custom labels
*/}}

{{- define "infinispan-helm-charts.podLabels" -}}
{{- range .Values.deploy.podLabels }}
{{ .key }}: {{ .value }}
{{- end }}
{{- end }}

{{/*
Service custom labels
*/}}

{{- define "infinispan-helm-charts.svcLabels" -}}
{{- range .Values.deploy.svcLabels }}
{{ .key }}: {{ .value }}
{{- end }}
{{- end }}

{{/*
Service selector labels
*/}}
{{- define "infinispan-helm-charts.selectorLabels" -}}
clusterName: {{ include "infinispan-helm-charts.name" . }}
app: infinispan-pod
{{- end }}

{{/*
Common annotations
*/}}
{{- define "infinispan-helm-charts.annotations" -}}
meta.helm.sh/release-name: {{ .Release.Name }}
meta.helm.sh/release-namespace: {{ .Release.Namespace }}
{{- end }}

{{/*
Include for indentation
*/}}
{{- define "infinispan-helm-charts.containerEnv" -}}
- name: JAVA_OPTIONS
  value: {{ .extraJvmOpts }}
- name: IDENTITIES_BATCH
  value: /etc/security/identities-batch
- name: SERVER_LIBS
  value: {{ .libraries }}
{{- if .env -}}
{{ .env | toYaml | nindent 0 }}
{{- end -}}
{{- end }}

{{/*
Schema for default endpoint
*/}}

{{- define "infinispan-helm-charts.defaultEndpointSchema" -}}
   {{- range .Values.deploy.infinispan.server.security.securityRealms }}
      {{- if eq .name "default" }}
         {{- if and .serverIdentities .serverIdentities.ssl -}}
               HTTPS
         {{- else -}}
               HTTP
         {{- end -}}
      {{- end -}}
   {{ end -}}
{{ end }}
