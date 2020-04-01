BUILD_NAME=python
OWNER=groovytron
COMPOSE_BUILD_NAME=python-container
VERSIONS=3.8 3.7 3.6
LATEST=3.8
LATEST_LABEL=latest
ALL=$(addprefix python,$(VERSIONS))
VCS_REF="$(shell git rev-parse HEAD)"
BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"

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
		docker tag $(COMPOSE_BUILD_NAME):$$VERSION $(OWNER)/$(BUILD_NAME):$$VERSION; \
	done && \
	docker tag $(COMPOSE_BUILD_NAME):$(LATEST) $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:publish
publish: tag
	for VERSION in $(VERSIONS); do \
		docker push $(OWNER)/$(BUILD_NAME):$$VERSION; \
	done && \
	docker push $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:clean-tests
clean-test:
	rm -rf test_pipenv test_poetry
