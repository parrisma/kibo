# Authorization Setup

## Self Signed Certs

In Ubuntu

```openssl genrsa -out kibo.key 4096```
```openssl req -new -x509 -sha256 -addext "subjectAltName = DNS:kibo.org" -days 10950 -key kibo.key -out kibo.crt```
```cat kibo.key | base64 -w 0 > SingleLineKey``
```cat kibo.crt | base64 -w 0 > SingleLineCrt``

Validate SAN name with

```openssl x509 -in kibo.crt -noout -text | grep Alternative```

On Ubuntu
```$ sudo cp kibo.crt /etc/ssl/certs```
```$ sudo cp kibo.key /etc/ssl/private```

On Windows
Double click crt to import into Windows, put specifically into ```Root Cert Auth.```

### Create Kube secret using 1-line base 64 encoding

On Ubuntu

```cat kibo.key | base64 -w 0 > oneline-base64-key```
```cat kibo.crt | base64 -w 0 > oneline-base64-cert```

[training video](https://github.com/ChristianLempa/videos/tree/main/self-signed-certificates-in-kubernetes)
[debugging k8s cert issuance](https://cert-manager.io/docs/troubleshooting/)

```kubectl describe certificaterequest```

[Cluster issuer cannot find secret](https://github.com/cert-manager/cert-manager/issues/2352)

## PowerShell

```Set-ExecutionPolicy RemoteSigned -Scope CurrentUser```
