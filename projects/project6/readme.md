Step - 1 : Create a namespace.
kubectl create namespace prometheus

Step - 2 : Install prometheus to K8S cluster.
helm install prometheus prometheus-community/prometheus \
--namespace prometheus \
--set alertmanager.persistentVolume.storageClass="monitor-ebs-storage" 

Step - 3 : Port forward to the prometheus server.
kubectl port-forward svc/prometheus-server 9090:80 -n prometheus

Step - 4 : Create a namespace.
kubectl create namespace grafana

Step - 5 : Install grafana to K8S cluster.
helm install grafana grafana/grafana \
--namespace grafana \
--set persistence.storageClassName="monitor-ebs-storage" \
--set persistence.enabled=true \
--set adminPassword='EKS!sAWSome' \
--values prometheus-datasource.yaml \
--set service.type=LoadBalancer

Step - 6 : Verify the grafana installation.
kubectl get all -n grafana

Step - 7 : Copy the load balancer dns name and search in browser.
Step - 8 : Enter Username and Password
Step - 9 : Click on Dashboard > Library panels > + > Import Dashboard
Step - 10 : Enter 6417 and client on load.
Step - 11 : Click on load below.

We have instrumented the datastore project code by adding libraries that support prometheus metrics.
This application now exposes the api "/actuator/prometheus" from which prometheus collects the metrics from.

Deploy datastore docker image with tag v31.0 which contains "/actuator/prometheus" api to the kubernetes cluster.

Deploy the service which routes the traffic to pods of that datastore deployment.

Update the prometheus-server configmap in prometheus namespace with below block under "scrape_configs".

scrape_configs:
- job_name: datastore-api
  metrics_path: '/actuator/prometheus'
  scrape_interval: 3s
  static_configs:
  - targets: ['mysv-cip.default:8081']
    labels:
    application: 'datastore-api'

In above block "mysv-cip" is the service name of datastore and "default" is the namespace name "8081" is the service port.

In the prometheus console search for "http_server_requests_seconds_count" metrics.

Alerting
Update the below configuration in prometheus-server configmap.
    groups:
    - name: datastore-app
      rules:
      - alert: InstanceDown
        expr: up{application="datastore-api"} == 0
        for: 5s
        labels:
          severity: critical
          team: devops
        annotations:
          summary: "Application is down."
          description: "Application is down."

Update the below two configuration blocks in alertmanager configmap.
For slack web hook visit api.slack.com > your apps > Incoming Webhooks
First Block:
This block defines where to send the notifications.
    receivers:
    - name: default-receiver
    - name: slack
      slack_configs:
      - channel: "#alerting"
        text: |
          {{ .CommonAnnotations.summary }}
          {{ .CommonAnnotations.description }}
        send_resolved: true
        api_url: 'https://hooks.slack.com/services/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'

Second Block:
This block defines in which case where to send notifications. For example for below case if team, severity matches with devops, critical then it will send the notification to slack receiver which we added in above configuration if not to default receiver which is empty.
    route:
      group_interval: 5m
      group_wait: 10s
      receiver: default-receiver
      repeat_interval: 3h
      routes:
      - matchers:
        - team=~"devops"
        - severity="critical"
        receiver: slack
        continue: true

Reload the alert manager after updating the configmap of alertmanager with below curl. Update the port based on service port mapping port.
curl -X POST http://localhost:9094/-/reload

Make the datastore application to down by updating the deployment with wrong path in liveness probe.
We will notice alerts in slack.