url=$(kubectl get svc envoy -n projectcontour -o jsonpath='{.status.loadBalancer.ingress[].hostname}')

for _ in {1..50}
do
    curl $url
    sleep 0.5
done