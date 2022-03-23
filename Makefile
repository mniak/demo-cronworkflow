cluster-up:
	k3d registry create demo-cronworkflow -p 5111
	k3d cluster create --registry-use k3d-demo-cronworkflow:5111 demo-cronworkflow
	kubectx k3d-demo-cronworkflow
	make install-argo

cluster-down:
	k3d registry delete demo-cronworkflow
	k3d cluster delete demo-cronworkflow

install-argo:
	kubectl create ns argo
	kubens argo
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml

image-build:
	docker build ./job01 -t localhost:5111/demo-cronworkflow-job01
	docker push localhost:5111/demo-cronworkflow-job01

image-test:
	make image-build
	docker run --rm localhost:5111/demo-cronworkflow-job01 TN-1234 555

demo-ns:
	kubectl create ns demo

apply:
	argo delete demojob
	kubectl create -f k8s/workflow.yaml

logs:
	argo get demojob
	argo logs demojob --follow
