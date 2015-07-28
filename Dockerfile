# Created by Jake Liscom (C) 2015
# Include LAMP stack
FROM tutum/lamp:latest

# Install dependencies
RUN apt-get update
RUN apt-get -y install wget unzip nodejs nodejs-legacy couchdb npm openssh-server supervisor curl
RUN mkdir -p /var/run/couchdb /var/log/supervisor

# Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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

# CouchDB
RUN npm install -g add-cors-to-couchdb
RUN chown -R couchdb /var/run/couchdb

ADD ./couchdb.config.sh /couchdb.config.sh
RUN chmod 700 couchdb.config.sh && chown root:root /couchdb.config.sh
RUN sh -x /couchdb.config.sh
RUN rm /couchdb.config.sh

# Open webservice ports
EXPOSE 80 443 5984 6984

# Start Everything
CMD ["/usr/bin/supervisord"]
