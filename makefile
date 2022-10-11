SCRIPT= core.sh
SCRIPTS= core_bash.sh
SCRIPTU= core-uninstall.sh
EXEC= core-gui
EXECS= core-bash
EXECU= core-uninstall
DESKTOP= core.desktop
IMAGE= mcore
CONTAINER= core


# paths
PREFIX = /usr/local
APPLICATION= /.local/share/applications/
SHARED= /Documents/Core
MANPREFIX = $(PREFIX)/share/man

install:
	sh install.sh
	mkdir -p $(PREFIX)/bin
	cp -f $(DESKTOP) $${HOME}$(APPLICATION)$(DESKTOP) 
	cp -f $(SCRIPT) $(PREFIX)/bin/$(EXEC)
	cp -f $(SCRIPTS) $(PREFIX)/bin/$(EXECS)
	cp -f $(SCRIPTU) $(PREFIX)/bin/$(EXECU)
	chmod 755 ${HOME}$(APPLICATION)$(DESKTOP)
	chmod 755 $(PREFIX)/bin/$(EXEC)
	chmod 755 $(PREFIX)/bin/$(EXECS)
	chmod 755 $(PREFIX)/bin/$(EXECU)
	chmod 777 $${HOME}$(SHARED)
	rm -r $(SCRIPT) $(SCRIPTU) $(SCRIPTS)

uninstall:
	docker container rm -f $(CONTAINER)
	docker rmi $(IMAGE)
	rm -f $(PREFIX)/bin/$(EXEC) $(PREFIX)/bin/$(EXECU)

uninstall_no_repo: uninstall
	rm makefile

.PHONY: install uninstall uninstall_no_repo

