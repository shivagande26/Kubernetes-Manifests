for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://18.207.120.148:31620/; done
