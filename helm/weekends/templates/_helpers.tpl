{{-  define "tomnginx.lables" }}
type: webapp
deployedby: shiva
with: helm
date: {{ now | htmlDate }}
{{- end }}