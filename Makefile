#!/bin/bash

.PHONY: all
all: create-cluster setup-argo build demo-namespace 

.PHONY: create-cluster
create-cluster:
	k3d cluster create demo-cronworkflow
	kubectx k3d-demo-cronworkflow

.PHONY: setup-argo
setup-argo:
	kubectl create ns argo
	kubens argo
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml

.PHONY: build
build:
	docker build ./job01 -t mniak/demo-cronworkflow-job01
	docker push mniak/demo-cronworkflow-job01
	# docker run --rm mniak/demo-cronworkflow-job01 TN-1234 555; echo $?

.PHONY: demo-namespace
demo-namespace:
	kubectl create ns demo

.PHONY: apply
apply: k8s/workflow.yaml
	argo delete demojob
	kubectl create -f k8s/workflow.yaml

.PHONY: logs
logs:
	argo get demojob
	argo logs demojob --follow
