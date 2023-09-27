url=$(kubectl get svc envoy -n projectcontour -o jsonpath='{.status.loadBalancer.ingress[].hostname}')

touch response_time.txt
while true
do
    curl -o /dev/null -s -w '%{time_total}s\n' $url >> response_time.txt
    sleep 0.5
done