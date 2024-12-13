for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://65.1.166.111:31030/; done
