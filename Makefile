BUILD_NAME=python-container
CONTAINER_NAME=my-python-container
COMMON_BUILD_TAGS=--build-arg VCS_REF="$(shell git rev-parse HEAD)" --build-arg BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"
TEST_FILES=.venv testsite Pipfile Pipfile.lock


.PHONY: all
all: 3.6 3.7

.PHONY: 3.6
3.6: python-3.6
	docker build \
		$(COMMON_BUILD_TAGS) \
		--file $< \
		--build-arg PIPENV_VERSION=2018.11.26 \
		--tag $(BUILD_NAME):$@ \
		.

.PHONY: 3.7
3.7: python-3.7
	docker build \
		$(COMMON_BUILD_TAGS) \
		--file $< \
		--build-arg PIPENV_VERSION=2018.11.26 \
		--build-arg PYTHON_VERSION=$@ \
		--tag $(BUILD_NAME):$@ \
		.

.PHONY:clean
clean:
	docker images | grep $(BUILD_NAME) | tr -s ' ' | cut -d ' ' -f2 | xargs -I {} echo $(BUILD_NAME):{}
	rm -rf $(TEST_FILES)

.PHONY:test-3.%
test-3.%:
	docker run \
		-it \
		--user=dev \
		-p 8000:8000 \
		-v $(shell pwd):/var/www/app \
		--entrypoint /var/www/app/test.sh \
		python-container:$(shell cut -d'-' -f2 <<<$@)
	rm -rf $(TEST_FILES)
