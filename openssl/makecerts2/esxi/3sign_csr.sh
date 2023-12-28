
openssl x509 -req -in rui.csr -CA ../../ca/root.crt -CAkey ../../ca/root.key -CAcreateserial -out rui.crt -days 5000 -sha256 -extensions v3_req -extfile v3.ext
