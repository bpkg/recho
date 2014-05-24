
BIN ?= recho
PREFIX ?= /usr/local
MANPREFIX ?= $(PREFIX)/share/man/man1

$(BIN): test man

test:
	./test.sh

install:
	cp recho.sh $(PREFIX)/bin/$(BIN)
	cp recho.1 $(MANPREFIX)/$(BIN).1

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
	rm -f $(MANPREFIX)/$(BIN).1

man:
	@curl -# -F page=@recho.1.md -o recho.1 http://mantastic.herokuapp.com
	@echo "recho.1"
