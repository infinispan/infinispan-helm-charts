## Quickstart: deploy a TLS cluster with HELM

kubectl apply -f test/tls_secret.yaml<br>
kubectl apply -f test/transport_tls_secret.yaml<br>
helm install infinispan . -f values.yaml -f test/tls_values.snippet.yaml --set deploy.replicas=2
