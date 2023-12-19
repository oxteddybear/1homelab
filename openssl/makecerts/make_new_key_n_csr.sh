#make new key and CSR
openssl req -out vcsa.csr -newkey rsa:4096 -nodes -keyout vcsa.key -config vcsa.v3
