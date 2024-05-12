echo "Starting all Keycloak resources..."
kubectl apply -f kibo-keycloak-secrets.yaml --namespace=kibo
kubectl apply -f kibo-keycloak-volumes.yaml --namespace=kibo
rem kubectl apply -f kibo-keycloak-postgres-ephemeral.yaml --namespace=kibo
kubectl apply -f kibo-keycloak-postgres-persisted.yaml --namespace=kibo
kubectl apply -f kibo-keycloak-service.yaml --namespace=kibo
kubectl apply -f kibo-keycloak.yaml --namespace=kibo
kubectl apply -f kibo-keycloak-ingress.yaml --namespace=kibo

