for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://3.82.28.168:31634/; done
