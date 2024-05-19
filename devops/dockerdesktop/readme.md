# Docker Desktop

## Helm

Run from windows power shell started as admin

## Cert Manager Setup

[docs](https://cert-manager.io/docs/installation/helm/)
```helm repo add jetstack https://charts.jetstack.io --force-update```
```helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.14.5 --set installCRDs=true```

## Ingress Set Up

```choco install kubernetes-helm```
```helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx   --namespace ingress-nginx --create-namespace```
```kubectl get service --namespace ingress-nginx ingress-nginx-controller --output wide --watch```
```wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s```
```POD_NAMESPACE=ingress-nginx```
```POD_NAME=$(kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --field-selector=status.phase=Running -o name)```
```kubectl exec $POD_NAME -n $POD_NAMESPACE -- /nginx-ingress-controller --version```

[helpful](https://phoenixnap.com/kb/install-helm)
[help2](https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html)

## Local mounts

```/run/desktop/mnt/host/c/Users/parri```