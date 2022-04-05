Demo of Argo ~~Cron~~ Workflow
==============================

#### Requirements: 
- Docker
- `k3d`
- GNU Make


#### Usage:
Open the file `Makefile` and change the variables in the indicated places.

Also, change the username prefix in the file `workflow-templates/demojob-template.yaml`


```bash
make cluster
make image

# Run 
make run-wf
# Or configure the workflow to run scheduled
make apply-cron

# Check
make show-logs

# Shutdown the cluster
make delete-cluster
```