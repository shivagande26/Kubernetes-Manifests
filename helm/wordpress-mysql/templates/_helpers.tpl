{{- define "wordpress.deploy.labels" }}
app: wordpress
{{- end }}

{{- define "wordpress.vol.labels" }}
type: local
date: {{ now | htmlDate }}
{{- end }}

{{- define "wordpress.ing.labels" }}
name: wordpress-ingress
date: {{ now | htmlDate }}
{{- end }}