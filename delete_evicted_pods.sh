
#!/bin/bash
kubectl get pods -n osh-infra | grep Evicted | awk '{print $1}' | xargs kubectl -n osh-infra delete pod

