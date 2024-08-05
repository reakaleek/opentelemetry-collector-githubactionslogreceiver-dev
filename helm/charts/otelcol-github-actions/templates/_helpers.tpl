{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "otelcol-github-actions.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "otelcol-github-actions.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "otelcol-github-actions.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "otelcol-github-actions.labels" -}}
helm.sh/chart: {{ include "otelcol-github-actions.chart" . }}
{{ include "otelcol-github-actions.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "otelcol-github-actions.selectorLabels" -}}
app.kubernetes.io/name: {{ include "otelcol-github-actions.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
githubactionslogreceiver port
*/}}
{{- define "otelcol-github-actions.receiver.port" }}
{{- printf "%d" 19419 }}
{{- end }}

{{- define "otelcol-github-actions.ip.whitelist" -}}
{{- $list := list }}
{{- range .Values.ip.whitelist }}
{{- $list = append $list (printf "%s" .) }}
{{- end }}
{{- join "," $list }}
{{- end }}
