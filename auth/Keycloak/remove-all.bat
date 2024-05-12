echo "Deleting all Keycloak resources..."
kubectl delete -f kibo-keycloak-ingress.yaml --namespace=kibo
kubectl delete -f kibo-keycloak.yaml --namespace=kibo
kubectl delete -f kibo-keycloak-service.yaml --namespace=kibo
kubectl delete -f kibo-keycloak-postgres-ephemeral.yaml --namespace=kibo
kubectl delete -f kibo-keycloak-postgres-persisted.yaml --namespace=kibo
kubectl delete -f kibo-keycloak-volumes.yaml --namespace=kibo
kubectl delete -f kibo-keycloak-secrets.yaml --namespace=kibo
