SOURCES = $(wildcard **/*.go)

.PHONY: test
test:
	go test ./...

terraform-provider-quantum: $(SOURCES)
	go build ./...

.PHONY: build
build: terraform-provider-quantum

.PHONY: install
install: terraform-provider-quantum
	cp terraform-provider-quantum $(shell dirname $(shell which terraform))

.PHONY: deploy
deploy:
	GOARCH=amd64 GOOS=linux go build -o .pkg/terraform-provider-quantum_linux
	GOARCH=amd64 GOOS=darwin go build -o .pkg/terraform-provider-quantum_darwin
	GOARCH=amd64 GOOS=windows go build -o .pkg/terraform-provider-quantum.exe
