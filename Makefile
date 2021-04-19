ENV_FILE := .env
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
CURRENT_DIR = $(shell pwd)

ANSIBLE_BUILDER = poetry run ansible-builder

.PHONY:
buildee:
	$(ANSIBLE_BUILDER) build -f $(BUILDER_EE_FILE) --tag $(ANSIBLE_RUNNER_IMAGE) \
       --container-runtime $(CONTAINER_RUNTIME)

.PHONY:	push
push:	buildee
	@$(CONTAINER_RUNTIME) push $(ANSIBLE_RUNNER_IMAGE)
