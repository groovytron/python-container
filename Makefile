BUILD_NAME=python
COMPOSE_BUILD_NAME=python-container
VERSIONS=3.7 3.6
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
