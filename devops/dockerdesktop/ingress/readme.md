# Ingress Controller

## Expose DNS

```apply -f kube-dns-ingress.yaml -n nginx-ingess```

then add this to the ingress nginx service

```kubectl edit service ingress-nginx-controller -n ingress-nginx```

```- name: proxied-dns-53```
```nodePort: 30481``` Node Port of the above service
```port: 53```
```protocol: UDP```
```targetPort: 53```

```kubectl edit deployment ingress-nginx-controller -n ingress-nginx```

then add the line below to args section, using spaces not tabs.

```- args:```
```- /nginx-ingress-controller```
```- --udp-services-configmap=$(POD_NAMESPACE)/udp-services```

When you save and exit the file it will either update teh deployment, or reopen the same file with the error in the comment section at the start of the file
