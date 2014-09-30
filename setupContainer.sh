#!/bin/bash

echo "CREATE DATABASE OpenNote" | mysql -u root
mysql -u root OpenNote < file.sql