for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://3.86.54.163:30289/; done
