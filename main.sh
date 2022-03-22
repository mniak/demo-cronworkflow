#!/bin/bash

k3d cluster create demo-cronworkflow
kubectx k3d-demo-cronworkflow

k create ns argo
kubens argo
k apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml

docker build ./job01 -t demo-cronworkflow:job01
# docker run --rm demo-cronworkflow:job01 TN-1234 555; echo $?

k create ns demo
k apply -k k8s