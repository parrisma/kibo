### Key Cloak Setup
## TLS Cert
Run me in a linux (ubuntu) shell
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=foo.bar.com"
See also details [here](https://shocksolution.com/2018/12/14/creating-kubernetes-secrets-using-tls-ssl-as-an-example/)
## Find Key Cloak On
Ingress makes KeyCloak available in browser at URL below on machine (localhost) where kube is running
`http://localhost:443/
## Demo set-up of https
[here(https://github.com/marcel-dempers/docker-development-youtube-series/blob/master/kubernetes/ingress/ingress.yaml)