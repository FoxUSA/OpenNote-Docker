#!/bin/bash
couchdb -b
sleep 5s
add-cors-to-couchdb

# Config CouchDB
    curl -X PUT http://127.0.0.1:5984/_config/httpd/bind_address -d '"0.0.0.0"'
    curl -X PUT http://127.0.0.1:5984/_config/admins/admin -d '"password"'
    curl -X PUT http://127.0.0.1:5984/_config/couch_httpd_auth/require_valid_user -d '"true"' \
         -u admin:password

# Create DB
curl -X PUT http://127.0.0.1:5984/opennote \
     -u admin:password

# Set permissions on opennote database
curl -X PUT http://localhost:5984/opennote/_security \
     -u admin:password \
     -H "Content-Type: application/json" \
     -d '{"admins": { "names": ["admin"], "roles": [] }, "members": { "names": ["admin"], "roles": [] } }'

# SSL
curl -X PUT http://localhost:5984/_config/daemons/httpsd \
     -u admin:password \
     -H "Content-Type: application/json" \
     -d '"{couch_httpd, start_link, [https]}"'

mkdir /etc/couchdb/cert
openssl genrsa > /etc/couchdb/cert/privkey.pem
openssl req \
        -new \
        -x509 \
        -key /etc/couchdb/cert/privkey.pem \
        -out /etc/couchdb/cert/mycert.pem \
        -days 1000 \
        -nodes \
        -subj "/C=US/CN=localhost"

#curl -X PUT http://127.0.0.1:5984/_config/ssl/cert_file \
#     -u admin:password \
#     -H "Content-Type: application/json" \
#     -d '"/etc/couchdb/cert/mycert.pem"'

#curl -X PUT http://127.0.0.1:5984/_config/ssl/key_file \
#     -u admin:password \
#     -H "Content-Type: application/json" \
#     -d '"/etc/couchdb/cert/privkey.pem"'

# Default SSL port 6984

couchdb -d
