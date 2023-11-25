openssl req -sha512 -new \
	    -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=$1" \
	    -key $1.key\
	    -out $1.csr
