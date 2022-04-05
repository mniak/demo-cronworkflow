# Change this variable
DOCKER_USERNAME=mniak

cluster:
	k3d cluster create argo
	kubectx k3d-argo
	make install-argo
	kubectl create ns demo
	kubens demo

install-argo:
	kubectl create ns argo
	kubens argo
	kubectl apply -f https://github.com/argoproj/argo-workflows/releases/download/v3.3.1/install.yaml
	
delete-cluster:
	k3d cluster delete argo

image:
	docker build ./job01 -t ${DOCKER_USERNAME}/demo-cronworkflow-job01
	docker push ${DOCKER_USERNAME}/demo-cronworkflow-job01

test-image: image
	docker run --rm ${DOCKER_USERNAME}/demo-cronworkflow-job01 TN-1234 555 70

run-job:
	kubectl apply -f k8s/templates/demojob.yaml
	argo submit --log k8s/workflows/demojob.yaml

show-logs:
	argo get demojob
	argo logs demojob --follow
