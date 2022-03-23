#!/bin/bash

do-help() {
	>&2 echo "No command specified"
}

do-cluster-up() {
	k3d registry create demo-cronworkflow -p 5111
	k3d cluster create --registry-use k3d-demo-cronworkflow:5111 demo-cronworkflow
	kubectx k3d-demo-cronworkflow
	do-install-argo
}

do-cluster-down() {
	k3d registry delete demo-cronworkflow
	k3d cluster delete demo-cronworkflow
}

do-install-argo() {
	kubectl create ns argo
	kubens argo
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml
}

do-image-build() {
	docker build ./job01 -t localhost:5111/demo-cronworkflow-job01
	docker push localhost:5111/demo-cronworkflow-job01
}

do-image-test() {
	do-image-build
	docker run --rm localhost:5111/demo-cronworkflow-job01 TN-1234 555
}

do-demo-ns() {
	kubectl create ns demo
}

do-apply() {
	argo delete demojob
	kubectl create -f k8s/workflow.yaml
}

do-logs() {
	argo get demojob
	argo logs demojob --follow
}

subcommand=$1
case $subcommand in
"" | "-h" | "--help")
    do-help
    ;;
*)
    shift
    do-${subcommand} $@
    if [ $? = 127 ]; then
        echo "Error: '$subcommand' is not a known subcommand." >&2
        echo "       Run '$ProgName --help' for a list of known subcommands." >&2
        exit 1
    fi
    ;;
esac
