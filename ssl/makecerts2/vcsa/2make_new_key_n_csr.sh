#make new key and CSR
openssl req -out vcsa1.csr -newkey rsa:4096 -nodes -keyout vcsa1.key -config v3.ext
