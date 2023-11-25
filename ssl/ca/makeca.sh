

make key n cert
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -sha512 -days 3650  -subj /C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=yourdomain.com  -key ca.key  -out ca.crt  

read the rest here:
https://goharbor.io/docs/2.9.0/install-config/configure-https/
