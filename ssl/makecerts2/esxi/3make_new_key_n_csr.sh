#make new key and CSR
openssl req -out 24.csr -newkey rsa:4096 -nodes -keyout rui.key -config v3.ext
