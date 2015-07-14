# Created by Jake Liscom (C) 2014
# Include LAMP stack
FROM tutum/lamp:latest

# Install dependencies
RUN apt-get update
RUN apt-get -y install wget unzip nodejs nodejs-legacy couchdb npm

# OpenNote install command
RUN rm -fr /app
ADD https://github.com/FoxUSA/OpenNote/releases/download/15.07/15.07.00.zip /app/OpenNote.zip
RUN unzip /app/OpenNote.zip -d /app

# Clean up
RUN rm /app/OpenNote.zip
RUN rm /app/Service/Config.*
RUN rm /app/Service/install.php

# Add pre-made config and setup script
ADD ./Config.php /app/Service/
ADD ./create_mysql_admin_user.sh /

# Set permissions
RUN chmod 755 /app -R
RUN chown www-data:www-data /app -R
RUN chmod 755 /*.sh

# Enable https server
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN service apache2 restart

# Open webservice ports
EXPOSE 80 443

# CouchDB
RUN npm install -g add-cors-to-couchdb
RUN couchdb -b
RUN add-cors-to-couchdb

# Config CouchDB
    RUN curl -X PUT http://127.0.0.1:5984/_config/httpd/bind_address -d '"0.0.0.0"'
    RUN curl -X PUT http://127.0.0.1:5984/_config/admins/admin -d '"password"'
    RUN curl -X PUT http://127.0.0.1:5984/_config/couch_httpd_auth/require_valid_user -d '"true"'

    # Create DB
    RUN curl -X PUT http://127.0.0.1:5984/opennote

    # Set permissions on opennote database
    RUN curl -X PUT http://localhost:5984/opennote/_security \
         -u admin:password \
         -H "Content-Type: application/json" \
         -d '{"admins": { "names": ["admin"], "roles": [] }, "members": { "names": ["admin"], "roles": [] } }'

    # SSL
    RUN curl -X PUT http://localhost:5984/_config/daemons/httpsd \
         -u admin:password \
         -H "Content-Type: application/json" \
         -d '"{couch_httpd, start_link, [https]}"'

    RUN mkdir /etc/couchdb/cert
    RUN openssl genrsa > /etc/couchdb/cert/privkey.pem
    RUN openssl req -new -x509 -key /etc/couchdb/cert/privkey.pem -out /etc/couchdb/cert/mycert.pem -days 1095

    RUN curl -X PUT http://127.0.0.1:5984/_config/ssl/cert_file \
         -u admin:password \
         -H "Content-Type: application/json" \
         -d '"/etc/couchdb/cert/mycert.pem"'

    RUN curl -X PUT http://127.0.0.1:5984/_config/ssl/key_file \
         -u admin:password \
         -H "Content-Type: application/json" \
         -d '"/etc/couchdb/cert/privkey.pem"'

    # Default SSL port 6984

    RUN couchdb -d

# Start the LAMP stack
CMD ["/run.sh","couchdb -b"]
