for i in {1..1000}; do curl -s -o /dev/null -w "%{http_code}\n" http://13.232.142.172:31230/; done
