#!/bin/bash
COUCHDB=http://$COUCHDB_PORT_5984_TCP_ADDR:$COUCHDB_PORT_5984_TCP_PORT

add-cors-to-couchdb $COUCHDB

# Config CouchDB
    curl -k -X PUT $COUCHDB/_config/httpd/bind_address -d '"0.0.0.0"'
    curl -k -X PUT $COUCHDB/_config/admins/admin -d '"password"'
    curl -k -X PUT $COUCHDB/_config/couch_httpd_auth/require_valid_user -d '"true"' \
         -u admin:password

# Create DB
curl -k -X PUT $COUCHDB/opennote \
     -u admin:password

# Set permissions on opennote database
curl -k -X PUT $COUCHDB/opennote/_security \
     -u admin:password \
     -H "Content-Type: application/json" \
     -d '{"admins": { "names": ["admin"], "roles": [] }, "members": { "names": ["admin"], "roles": [] } }'
