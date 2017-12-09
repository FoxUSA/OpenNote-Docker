# Created by Jake Liscom (C) 2017
FROM nginx

# Install dependencies
RUN apt-get update
RUN apt-get -y install wget unzip openssh-server curl nano

# OpenNote install command

ADD https://github.com/FoxUSA/OpenNote/releases/download/18.03.00-Alpha/18.03.00-Alpha.zip /tmp/OpenNote.zip
RUN unzip -o /tmp/OpenNote.zip -d /usr/share/nginx/html/

# Clean up
RUN rm -rf /tmp/

# Set permissions
RUN chmod 755 /usr/share/nginx/html/ -R
