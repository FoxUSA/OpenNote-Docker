# Created by Jake Liscom (C) 2015
# Include LAMP stack
FROM tutum/lamp:latest

# Install dependencies
RUN apt-get update
RUN apt-get -y install wget unzip nodejs nodejs-legacy npm openssh-server curl nano

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

# Setup
RUN npm install -g add-cors-to-couchdb

ADD ./setup.sh /setup.sh
RUN chmod 700 setup.sh && chown root:root /setup.sh

# Open webservice ports
EXPOSE 80 443

# Start Everything
CMD ["/run.sh"]
