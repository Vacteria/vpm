#!/usr/bin/make -f

DESTDIR =
PREFIX  = /usr
CONFDIR = $(PREFIX)/etc/vpm
DATA    = $(PREFIX)/share/vpm
BIN     = $(PREFIX)/bin
DIRS    = vpmbuild vpmget vpmrepo

vpmqdb :
	make -C gdbm 
	sed -i -e "s#@PREFIX@#$(PREFIX)#g" conf/vpm.conf

install-vpm :
	install -D -d -m0755 $(DESTDIR)/$(DATA)/common
	install -D -d -m0755 $(DESTDIR)/$(DATA)/vpm
	install -D -d -m0755 $(DESTDIR)/$(BIN)
	install -D -d -m0755 $(DESTDIR)/$(CONFDIR)
	
	install -m0644 bash/common/* $(DESTDIR)/$(DATA)/common
	install -m0644 bash/vpm/* $(DESTDIR)/$(DATA)/vpm
	install -m0644 conf/* $(DESTDIR)/$(CONFDIR)
	
	install -m 0755 bash/vpm.in $(DESTDIR)/$(BIN)/vpm
	install -m 0755 gdbm/vpmqdb $(DESTDIR)/$(BIN)
	
install-devel :
	install -D -d -m0755 $(DESTDIR)/$(DATA)/
	install -D -d -m0755 $(DESTDIR)/$(BIN)

	for I in $(DIRS); do \
		install -m0755 bash/$$I.in $(DESTDIR)/$(BIN)/$$I; \
	done
	for I in $(DIRS); do \
		install -D -d -m0755 $(DESTDIR)/$(DATA)/$$I; \
		install -m0644 bash/$$I/* $(DESTDIR)/$(DATA)/$$I; \
	done 
	
install : install-vpm install-devel

clean :
	make -C gdbm clean
