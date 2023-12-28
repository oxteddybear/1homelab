cat > v3.ext <<-EOF
[req]
default_bits = 2048
default_keyfile = rui.key
distinguished_name = req_distinguished_name
encrypt_key = no
prompt = no
string_mask = nombstr
req_extensions = v3_req

[req_distinguished_name]
countryName = SG
stateOrProvinceName = SINGAPORE
localityName = SINGAPORE
0.organizationName = DUCKY
organizationalUnitName = QUACK
commonName = esx2.leafy.branch

[v3_req]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=esx24.rubber.ducky
DNS.2=esx2.leafy.branch
IP.1=10.149.83.24
EOF

