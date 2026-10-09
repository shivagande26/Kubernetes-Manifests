for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://54.174.152.92:31911/; done
