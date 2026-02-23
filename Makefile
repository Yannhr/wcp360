.PHONY: all build dev run tidy clean frontend frontend-dev

all: tidy build

build:
   ^I  mkdir -p bin
   ^I  go build -o bin/wcpd ./cmd/wcpd

dev: build
	./bin/wcpd --debug

run: build
	./bin/wcpd

tidy:
	go mod tidy

clean:
	rm -rf bin/

frontend:
	cd panel && pnpm install && pnpm build

frontend-dev:
	cd panel && pnpm dev
