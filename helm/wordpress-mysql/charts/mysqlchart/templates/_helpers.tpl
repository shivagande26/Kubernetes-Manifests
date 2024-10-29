{{- define "mysql.labels" }}
app: mysql
{{- end }}

{{- define "mysqlPv.labels" }}
type: local
date: {{ now | htmlDate }}
{{- end }}

{{- define "mysqlPvc.labels" }}
type: local
date: {{ now | htmlDate }}
{{- end }}