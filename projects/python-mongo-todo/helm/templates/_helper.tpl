{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "flaskapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper flaskapp image name
*/}}
{{- define "flaskapp.image" -}}
{{- $registryName := .Values.flaskapp.image.registry -}}
{{- $repositoryName := .Values.flaskapp.image.repository -}}
{{- $tag := .Values.flaskapp.image.tag | toString -}}
{{- if $registryName -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper mongo image name
*/}}
{{- define "mongo.image" -}}
{{- $registryName := .Values.mongo.image.registry -}}
{{- $repositoryName := .Values.mongo.image.repository -}}
{{- $tag := .Values.mongo.image.tag | toString -}}
{{- if $registryName -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}