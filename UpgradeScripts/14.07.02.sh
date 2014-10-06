#!/bin/bash
wget https://github.com/FoxUSA/OpenNote/releases/download/14.07.02/OpenNote.zip -P /app/~upgrade

#Unpack the new version except config and install files
unzip -o /app/~upgrade/OpenNote.zip -d /app -x *openNote.config.js *Service/Config.* *Service/install.php

#Re permission
chmod 755 /app -R
chown www-data:www-data /app -R
chmod 755 /*.sh

#Delete OpenNote.zip and self
rm -r /app/~upgrade