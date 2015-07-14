#!/bin/bash
wget https://github.com/FoxUSA/OpenNote/releases/download/16.06.02/OpenNote.zip -P /app/~upgrade/

#Unpack the new version except config and install files
unzip -o /app/~upgrade/OpenNote.zip -d /app -x openNote/openNote.config.js Service/Config.* Service/install.php

#Change version number in GUI
sed -i 's/14.07.01/14.07.02/g' /app/openNote/openNote.config.js

#Re permission
chmod 755 /app -R
chown www-data:www-data /app -R
chmod 755 /*.sh

#Delete OpenNote.zip and self
rm -r /app/~upgrade
