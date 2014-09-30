OpenNote-Docker
===============

Files needed for OpenNote Docker deployment

## Build
`sudo docker build --no-cache=true -t opennote .`

## Run
`sudo docker run -d -p 80:80 -p 443:443 opennote`
or if 80 is in use
`sudo docker run -d -p 8080:80 -p 8443:443 opennote`


