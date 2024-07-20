# Rancher Instal

[video](https://www.youtube.com/watch?v=hT2_O2Yd_wE)

## Add the Jetstack Helm repository
```helm repo add jetstack https://charts.jetstack.io```

## Update your local Helm chart repository cache
```helm repo update```

## Install the cert-manager Helm chart
```helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true --version v1.11.0```


## Install rancher
```helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=arther.local.rancher --set bootstrapPassword=admin```

### Test, takes about 10 mins to fully start

```kubectl -n cattle-system rollout status deploy/rancher```
```kubectl -n cattle-system get deploy rancher```

## Install K3 load balancer MetalLB

[Turn of defautl K3S loadbalancer](https://documentation.breadnet.co.uk/kubernetes/k3s/disable-klipper/)
[Enable Metal BL](https://blog.chicho.com.ar/how-to-deploy-a-kubernetes-cluster-with-k3s/)

## Expose the Rancher service with IP outside of private cluster

```kubectl expose deployment rancher --name=rancher-lb --port=443 --type=LoadBalancer -n cattle-system```

```$ kubectl get svc -n cattle-system```
```NAME              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)          AGE```
```rancher           ClusterIP      10.43.126.75    <none>          80/TCP,443/TCP   72m```
```rancher-webhook   ClusterIP      10.43.45.251    <none>          443/TCP          66m```
```rancher-lb        LoadBalancer   10.43.238.190   192.168.70.51   443:30850/TCP    11s```

## Rancher UI in browser

```https://192.168.70.51/```

## Uninstall

[Clean up](https://github.com/rancher/rancher-cleanup)