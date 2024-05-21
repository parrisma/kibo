# Helm

## Helm Tests

Can use this image to run Kubectl commands as part of teh helm tests

```docker run --rm --name kubectl -v C:\Users\parri\.kube\config:/.kube/config bitnami/kubectl:latest get nodes```

```docker run --rm --name kubectl -v C:\Users\parri\.kube\config:/.kube/config bitnami/kubectl:latest get cert kibo-cert -o=jsonpath='{.status.conditions[0].status}' -n kibo```

## Deploy

```helm dependency build kibo-keycloak -n kibo```
