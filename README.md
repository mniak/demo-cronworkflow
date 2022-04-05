Demo of Argo ~~Cron~~ Workflow
==============================

#### Requirements: 
- Docker
- `k3d`
- GNU Make


#### Usage:
Open the file `Makefile` and change the variables in the indicated places.


```bash
make cluster
make image

# Run 
make run-wf
# Or configure the workflow to run scheduled

# Check
make show-logs

# Shutdown the cluster
make delete-cluster
```