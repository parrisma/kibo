docker run -it --rm -v ${PWD}:/work -w /work debian:buster bash
apt-get update && apt-get install -y curl &&
curl -L https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl && \
curl -L https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson && \
chmod +x /usr/local/bin/cfssl && \
chmod +x /usr/local/bin/cfssljson

#generate certificate
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname="vault-svc,vault-svc.kibo.svc.cluster.local,vault-svc.kibo.svc,localhost,127.0.0.1" \
  -profile=default \
  vault-csr.json | cfssljson -bare vault-kibo

#get values to make a secret
cat ca.pem | base64 | tr -d '\n'
cat vault-kibo.pem | base64 | tr -d '\n'
cat vault-kibo-key.pem | base64 | tr -d '\n'

cat <<EOF > ./vault-tls-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: vault-kibo-tls-secret
type: Opaque
data:
  vault-kibo.pem: $(cat vault-kibo.pem | base64 | tr -d '\n')
  vault-kibo-key.pem: $(cat vault-kibo-key.pem | base64 | tr -d '\n') 
  ca.pem: $(cat ca.pem | base64 | tr -d '\n')
EOF
