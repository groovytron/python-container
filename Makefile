BUILD_NAME=python
OWNER=groovytron
COMPOSE_BUILD_NAME=python-container
VERSIONS=3.8 3.7 3.6
LATEST=3.8
LATEST_LABEL=latest
ALL=$(addprefix python,$(VERSIONS))
VCS_REF="$(shell git rev-parse HEAD)"
BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"
CURRENT_DATE="$(shell date +"%Y%m%d")"

.PHONY: all
all: $(ALL)

.PHONY: $(ALL)
$(ALL):
	BUILD_DATE=$(BUILD_DATE) \
	BUILD_NAME=$(BUILD_NAME) \
	COMPOSE_BUILD_NAME=$(COMPOSE_BUILD_NAME) \
	VCS_REF=$(VCS_REF) \
	docker-compose -f build.yml build \
		$@

.PHONY:clean
clean:
	for VERSION in $(VERSIONS); do \
		docker image rm -f $(COMPOSE_BUILD_NAME):$$VERSION; \
	done

.PHONY:tag
tag:
	for VERSION in $(VERSIONS); do \
		docker tag $(COMPOSE_BUILD_NAME):$$VERSION $(OWNER)/$(BUILD_NAME):$$VERSION && \
		docker tag $(COMPOSE_BUILD_NAME):$$VERSION $(OWNER)/$(BUILD_NAME):$$VERSION-$(CURRENT_DATE); \
	done && \
	docker tag $(COMPOSE_BUILD_NAME):$(LATEST) $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:publish
publish: tag
	for VERSION in $(VERSIONS); do \
		docker push $(OWNER)/$(BUILD_NAME):$$VERSION && \
		docker push $(OWNER)/$(BUILD_NAME):$$VERSION-$(CURRENT_DATE); \
	done && \
	docker push $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:clean-tests
clean-test:
	rm -rf test_pipenv test_poetry

.PHONY:build-3.12
build-3.12:
	buildah build -f 3.12/Dockerfile -t localhost/$(COMPOSE_BUILD_NAME):3.12 \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VCS_REF=$(VCS_REF) \
		--build-arg POETRY_VERSION=1.8.4
