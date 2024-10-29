{{- define "app.labels"  }}
deployedby: shiva
with: helm
date: {{ now | htmlDate }}
{{- end }}