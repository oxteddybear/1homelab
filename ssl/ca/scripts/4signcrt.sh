openssl x509 -req -sha512 -days 3650 \
	    -extfile v3.ext \
	    -CA ../ca.crt -CAkey ../ca.key -CAcreateserial \
	    -in $1.csr \
        -out $1.crt
