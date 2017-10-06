ORG=khanlab
NAME=neuroglia
VERSION = 0.0.1

DOCKER_NAME=$(ORG)/$(NAME):$(VERSION)
SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)
SIZE=10000



	
docker_build: 
	docker build -t $(DOCKER_NAME) --rm .

singularity_build:
	singularity create  --force --size $(SIZE) $(SINGULARITY_NAME).img 
	sudo singularity bootstrap  $(SINGULARITY_NAME).img Singularity

tag_latest:
	docker tag $(DOCKER_NAME) $(DOCKER_LATEST)

docker_push:
	docker push $(DOCKER_NAME)

docker_push_latest:
	docker push $(DOCKER_LATEST)

docker_run:
	docker run --rm -it $(DOCKER_NAME) /bin/bash	

docker_last_built_date:
	docker inspect -f '{{ .Created }}' $(DOCKER_NAME)

