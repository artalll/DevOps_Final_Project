{{/*
Return the chart name
*/}}
{{- define "quakewatch-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Return the full name (release + chart)
*/}}
{{- define "quakewatch-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{/*
Common labels used in templates
*/}}
{{- define "quakewatch-chart.labels" -}}
app.kubernetes.io/name: {{ include "quakewatch-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
