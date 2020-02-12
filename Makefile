PROJECT ?= piraeus-client
REGISTRY ?= daocloud.io/piraeus
BASE ?= alpine 
TAG ?= latest
NOCACHE ?= false

help:
	@echo "Useful targets: 'update', 'upload'"

all: update upload

.PHONY: update
update:
	docker build -f Dockerfile.$(BASE) --no-cache=$(NOCACHE) --build-arg TAG=${TAG} --build-arg http_proxy=$(PROXY) --build-arg https_proxy=$(PROXY) -t $(PROJECT):$(TAG).$(BASE) .
	docker tag $(PROJECT):$(TAG).$(BASE) $(PROJECT):latest.$(BASE)

.PHONY: upload
upload:
	for r in $(REGISTRY); do \
		docker tag $(PROJECT):$(TAG).$(BASE) $$r/$(PROJECT):$(TAG).$(BASE) ; \
		docker tag $(PROJECT):$(TAG).$(BASE) $$r/$(PROJECT):latest.$(BASE) ; \
		docker push $$r/$(PROJECT):$(TAG).$(BASE) ; \
		docker push $$r/$(PROJECT):latest.$(BASE) ; \
	done