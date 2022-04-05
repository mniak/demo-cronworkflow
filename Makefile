# Change this variable
DOCKER_USERNAME=mniak

cluster:
	k3d cluster create argo
	kubectx k3d-argo
	kubectl create ns argo
	kubens argo
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml
	kubectl create ns demo
	kubens demo

delete-cluster:
	k3d cluster delete argo

image:
	docker build ./job01 -t ${DOCKER_USERNAME}/demo-cronworkflow-job01
	docker push ${DOCKER_USERNAME}/demo-cronworkflow-job01

test-image: image
	docker run --rm ${DOCKER_USERNAME}/demo-cronworkflow-job01 TN-1234 555

apply:
	argo delete demojob
	kubectl create -f k8s/workflow.yaml

logs:
	argo get demojob
	argo logs demojob --follow
