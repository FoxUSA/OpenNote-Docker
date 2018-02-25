# OpenNote-Docker

Docker is the default install method for OpenNote. Please see [these instructions](https://github.com/FoxUSA/OpenNote/blob/master/Doc/Install.md) in the main OpenNote repository.

## Compose

- `docker-compose up` bring up app. `-d` to detach it
- `docker-compose down` bring down app and delete containers

## Build/Deploy

- [ ] Test Docker file using `CWD:test` `sudo docker-compose up`
- [ ] Build container `sudo docker build --no-cache=true -t foxusa/opennote .`
- [ ] Push container `sudo docker push foxusa/opennote`. If you are getting an error you may need to run `docker login`.
