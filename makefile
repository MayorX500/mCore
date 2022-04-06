SCRIPT= core.sh
SCRIPTU= core-uninstall.sh
EXEC= core-gui
EXECU= core-uninstall
IMAGE= mcore
CONTAINER= core


# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

install:
	sh install.sh
	mkdir -p $(PREFIX)/bin
	cp -f $(SCRIPT) $(PREFIX)/bin/$(EXEC)
	cp -f $(SCRIPTU) $(PREFIX)/bin/$(EXECU)
	chmod 755 $(PREFIX)/bin/$(EXEC)
	chmod 755 $(PREFIX)/bin/$(EXECU)
	rm -r $(SCRIPT) $(SCRIPTU)

uninstall:
	docker container rm -f $(CONTAINER)
	docker rmi $(IMAGE)
	rm -f $(PREFIX)/bin/$(EXEC) $(PREFIX)/bin/$(EXECU)

.PHONY: install uninstall

