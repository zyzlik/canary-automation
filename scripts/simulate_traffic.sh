url=$(kubectl get svc envoy -n projectcontour -o jsonpath='{.status.loadBalancer.ingress[].hostname}')

for _ in {1..30}
do
    curl $url
    sleep 1
done