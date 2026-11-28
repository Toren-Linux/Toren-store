.PHONY: all build test clean run-ui

PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share/toren/store

all: build

build:
	cd cmd/toren-store && go build -o ../../bin/toren-store .

test:
	cd cmd/toren-store && go test -v ./...
	cd ui/lib && node --test store.test.mjs

run-ui:
	quickshell -p ui/store.qml

install: build
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 bin/toren-store $(DESTDIR)$(BINDIR)/toren-store
	install -d $(DESTDIR)$(DATADIR)
	cp -r ui $(DESTDIR)$(DATADIR)/
	cp -r catalog $(DESTDIR)$(DATADIR)/

clean:
	rm -rf bin/
