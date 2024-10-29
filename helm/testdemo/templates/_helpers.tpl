{{- define "app.labels" }}
a: b
c: d
date: {{ now | htmlDate }}
{{- end }}