.RECIPEPREFIX := $(.RECIPEPREFIX) 
.DEFAULT_GOAL := help
.PHONY: *

help:
  @echo "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m"
  @grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-32s\033[0m %s\n", $$1, $$2}'

build: ## Build image. Usage: make build TAG="7.0-cli"
  @docker build --no-cache --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -t yougmal/dev:$(TAG) -f $(TAG).Dockerfile .

build-nginx: ## Build mysql images
  make build TAG="dev-nginx"

build-all: ## Build all images
  make build-nginx
 
push-nginx: ## Push built mysql images to Docker Hub
  @docker push yougmal/dev:dev-nginx

push-all: ## Push all built images to Docker Hub
  make push-nginx
  
build-and-push: ## Build all images and push them to Docker Hub
  make build-all
  make push-all
  
clean: ## Clean all containers and images on the system
  -@docker ps -a -q | xargs docker rm -f
  -@docker images -q | xargs docker rmi -f
