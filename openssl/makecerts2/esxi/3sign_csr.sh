
openssl x509 -req -in 24.csr -CA ../../ca/root.crt -CAkey ../../ca/root.key -CAcreateserial -out 24.crt -days 5000 -sha256 -extensions v3_req -extfile v3.ext
