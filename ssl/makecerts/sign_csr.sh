
openssl x509 -req -in vcsa.csr -CA ../ca/root.crt -CAkey ../ca/root.key -CAcreateserial -out vcsa.crt -days 5000 -sha256 -extensions v3_req -extfile vcsa.v3
