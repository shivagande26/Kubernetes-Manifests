for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://65.0.134.90:32358/; done
