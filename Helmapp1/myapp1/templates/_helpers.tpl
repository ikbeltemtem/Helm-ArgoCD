{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}


{{- define "myapp1.microservices" -}}
{{- list .Values.microA.name .Values.microB.name }}  {{/* Add more microservices as needed */}}
{{- end }}


{{- define "myapp1.fullname" -}}
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


{{- define "myapp1.microA.serviceAccountName" -}}
{{- if .Values.microA.serviceAccount.create }}
{{- default (include "myapp1.fullname" .) .Values.microA.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.microA.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "myapp1.microB.serviceAccountName" -}}
{{- if .Values.microB.serviceAccount.create }}
{{- default (include "myapp1.fullname" .) .Values.microB.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.microB.serviceAccount.name }}
{{- end }}
{{- end }}
