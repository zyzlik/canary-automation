url=$(kubectl get svc envoy -n projectcontour -o jsonpath='{.status.loadBalancer.ingress[].hostname}')

while true
do
    curl $url
    sleep 0.5
done