linkerd install --crds | kubectl apply -f -

linkerd install | kubectl apply -f -

linkerd viz install | kubectl apply -f -

linkerd smi install | kubectl apply -f -

# Install Contour Ingress

kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
kubectl apply -f - << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: envoy
  namespace: projectcontour
EOF

kubectl patch daemonset envoy -n projectcontour --type json -p='[{"op": "add", "path": "/spec/template/spec/serviceAccount", "value": "envoy"}]'
kubectl patch daemonset envoy -n projectcontour --type json -p='[{"op": "replace", "path": "/spec/template/spec/automountServiceAccountToken", "value": true}]'
kubectl -n projectcontour get daemonset -oyaml | linkerd inject - | kubectl apply -f -
kubectl -n projectcontour get deployment -oyaml | linkerd inject - | kubectl apply -f -
