openssl x509 -req -in vcsa.csr -CA ../ca.crt -CAkey ../ca.key -CAcreateserial -out vcsa.crt -days 5000 -sha256 -extensions v3_req -extfile v3.ext
# go to wix.com sign in thebrownteddybear@gmail.com vsphere cert stuff
#Signing Certs
You need to specify -extensions to load the [v3_req] that you specified in the config file and add that file as an extension with -extfile or the SAN will not appear.

#With SAN
openssl x509 -req -in vcsa4.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out vcsa4.crt 
-days 5000 -sha256 -extensions v3_req -extfile vcsa4.cfg

#To See inside the CSR or Cert
openssl req -in vcsa5.csr -noout -text

#Verify cert content
openssl x509 -in mydomain.com.crt -text -noout
