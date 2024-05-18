# Key Cloak Setup

## TLS Cert

Run me in a linux (ubuntu) shell
```openssl genrsa -out ca.key 4096```
```openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt```

then base64 encode for use with secret

```cat ca.crt | base64 -w 0```
```cat ca.key | base64 -W 0```

See also details [here](https://shocksolution.com/2018/12/14/creating-kubernetes-secrets-using-tls-ssl-as-an-example/) and [here](https://www.youtube.com/watch?v=IQ3G8Z1myMw)

Import into Windows Root CA, by double clicking the ca.crt file and putting in Trusted Root CA
To verify 
```Windows Key + R```
```certmgr.msc```

## Find Key Cloak On

Ingress makes KeyCloak available in browser at URL below on machine (localhost) where kube is running
```http://localhost:443/```

## Demo set-up of https

[here](https://github.com/marcel-dempers/docker-development-youtube-series/blob/master/kubernetes/ingress/ingress.yaml)

## Test via port forward

```kubectl port-forward service/keycloak-svc 8443:80 -n kibo```