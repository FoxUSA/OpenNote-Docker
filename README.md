OpenNote-Docker
===============

Files needed for OpenNote Docker deployment

Make sure docker is running in daemon mode with restart previously running containers on (`docker -d -r`) or you could lose your notes if you do not know what you're doing.

## Build
`sudo docker build --no-cache=true -t opennote .`

Cleanup

`docker kill couchdb && docker rm couchdb && docker kill opennote && docker rm opennote`

## Run

### Start couchdb
`docker pull klaemo/couchdb-ssl:latest`

`docker run -d -p 5984:5984 -p 6984:6984 --name couchdb klaemo/couchdb-ssl`

### Star OpenNote setup

`sudo docker run -it --link couchdb opennote sh setup.sh`

### Start

`sudo docker run -d -P --name opennote opennote`

or if port 80 is in use

`sudo docker run -d -p 8080:80 -p 8443:443 --name opennote opennote`

your connection string will be something like `http://admin:password@127.0.0.1:5984/opennote`
