#make new key and CSR
openssl req -out rui.csr -newkey rsa:4096 -nodes -keyout rui.key -config v3.ext
