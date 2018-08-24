SHELL=/bin/bash
NAME=tkbk-demo
DOCKER_REGISTRY=10.254.0.50:5000
TAG=v1
IMAGE=${DOCKER_REGISTRY}/${NAME}:${TAG}
IMAGE_PULL_POLICY=Always
SCHEDULE=4 */1 * * *

all: build push deploy

build:
	@docker build -t ${IMAGE} .

push:
	@docker push ${IMAGE}

cp:
	@find ./manifests -type f -name "*.sed" | sed s?".sed"?""?g | xargs -I {} cp {}.sed {}

sed:
	@find ./manifests -type f -name "*.yaml" | xargs sed -i s?"{{.name}}"?"${NAME}"?g
	@find ./manifests -type f -name "*.yaml" | xargs sed -i s?"{{.namespace}}"?"${NAMESPACE}"?g
	@find ./manifests -type f -name "*.yaml" | xargs sed -i s?"{{.image}}"?"${IMAGE}"?g
	@find ./manifests -type f -name "*.yaml" | xargs sed -i s?"{{.image.pull.policy}}"?"${IMAGE_PULL_POLICY}"?g
	@find ./manifests -type f -name "*.yaml" | xargs sed -i s?"{{.schedule}}"?"${SCHEDULE}"?g

deploy: cp sed
	@kubectl create -f ./manifests/.

clean:
	@kubectl delete -f ./manifests/.
	@find ./manifests -type f -name "*.yaml" | xargs rm -f

