#!/bin/bash

# create localhost ssl cert and key files
openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

THISDIR=$PWD
# create https-server.sh
echo "http-server --ssl --cert $THISDIR/localhost.crt --key $THISDIR/localhost.key" > https-server.sh

# make executable
chmod u+x https-server.sh

# create symbolic link
sudo ln -sf $THISDIR/https-server.sh /bin/ws