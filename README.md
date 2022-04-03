Demo of Argo ~~Cron~~ Workflow
==============================

#### Requirements: 
- Docker
- `k3d`
- GNU Make


#### Usage:
Open the file `Makefile` and change the variables in the indicated places.


```bash
make up
make build
make apply
make logs

# Shutdown the cluster
make down
```