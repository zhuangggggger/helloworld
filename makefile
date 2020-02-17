TAG=$(shell cat main.go | grep 'Version =' | sed 's/.*\"\(.*\)\".*/\1/g')
GOBUILD=CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
BIN_NAME=helloworld
IMAGE_NAME=hello-world
DOCKER_USER_NAME=zhuangggggger
IMAGE=$(DOCKER_USER_NAME)/$(IMAGE_NAME):$(TAG)

.PHONY : target image
all: image

target:
	$(GOBUILD) -o dist/$(BIN_NAME) main.go

image: target
	mkdir -p dist
	cp ./dockerfile ./dist
	cd dist && docker build -t $(IMAGE) .
	rm -rf dist

push:
	docker push $(IMAGE)
