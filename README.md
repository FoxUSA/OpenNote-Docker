OpenNote-Docker
===============

Files needed for OpenNote Docker deployment

Make sure docker is running in daemon mode with restart previously running containers on (`docker -d -r`) or you could lose your notes if you do not know what you're doing.

## Build
`sudo docker build --no-cache=true -t opennote .`

## Run
`sudo docker run -d -p 80:80 -p 443:443 opennote`

or if port 80 is in use

`sudo docker run -d -p 8080:80 -p 8443:443 opennote`


