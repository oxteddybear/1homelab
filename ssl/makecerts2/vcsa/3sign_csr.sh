
openssl x509 -req -in vcsa1.csr -CA ../../ca/root.crt -CAkey ../../ca/root.key -CAcreateserial -out vcsa1.crt -days 5000 -sha256 -extensions v3_req -extfile v3.ext
