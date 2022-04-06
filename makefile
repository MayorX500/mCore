SCRIPT= core.sh
EXEC= core-gui
IMAGE= mcore

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

install:
	sh install.sh
	mkdir -p $(PREFIX)/bin
	cp -f $(SCRIPT) $(PREFIX)/bin/$(EXEC)
	chmod 755 $(PREFIX)/bin/$(EXEC)
	rm -r $(SCRIPT)

uninstall:
	docker container rm -f $(SCRIPT)
	docker rmi $(IMAGE)
	rm -f $(DESTDIR)$(PREFIX)/bin/$(EXEC)

.PHONY: install uninstall

