# OpenNote-Docker

//TODO provide db setup instructions. Not really worth automatically due to complexity and the fact you only ever need to do it once.
Use the couchdb setup steps below.

## Compose
- `docker-compose up` bring up app. `-d` to detach it
- `docker-compose down` bring down app and delete containers

`http://admin:password@127.0.0.1:5984/opennote`

## CouchDB Setup
- http://127.0.0.1:5984/_utils/#setup/singlenode
- http://127.0.0.1:5984/_utils/#_config/nonode@nohost/cors


## CouchDB Setup checklist
- [ ] Create user and require auth
- [ ] Bind to 0.0.0.0
- [ ] Create database
- [ ] [Enable CORS](
https://github.com/pouchdb/add-cors-to-couchdb)
