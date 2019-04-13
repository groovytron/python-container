BUILD_NAME=python-container
CONTAINER_NAME=my-python-container
COMMON_BUILD_TAGS=--build-arg VCS_REF="$(shell git rev-parse HEAD)" --build-arg BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"


.PHONY: all
all: build

.PHONY: build
build: Dockerfile
	docker build \
		$(COMMON_BUILD_TAGS) \
		--build-arg PIPENV_VERSION=2018.11.26 \
		--tag $(BUILD_NAME):latest .

.PHONY:clean
clean:
	docker image rm -f $(BUILD_NAME):latest
	rm -rf .venv testsite Pipfile Pipfile.lock

.PHONY:test
test:
	docker run \
		-it \
		--user=dev \
		-p 8000:8000 \
		-v $(shell pwd):/var/www/app \
		--entrypoint /var/www/app/test.sh \
		python-container:latest
