PREFIX='/usr'
DESTDIR=''
PROGRAM_NAME := $(shell grep ^PROGRAM_NAME INFO | cut -d= -f2)
EXECUTABLE_NAME := $(shell grep ^EXECUTABLE_NAME INFO | cut -d= -f2)
AUTHOR := $(shell grep ^AUTHOR INFO | cut -d= -f2)
VERSION := $(shell grep ^VERSION INFO | cut -d= -f2)
LICENSE := $(shell grep ^LICENSE INFO | cut -d= -f2)
DESCRIPTION := $(shell grep ^DESCRIPTION INFO | cut -d= -f2)
URL := $(shell grep ^URL INFO | cut -d= -f2)
MAIL := $(shell grep ^MAIL INFO | cut -d= -f2 | tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
TIMESTAMP = $(shell LC_ALL=C date '+%a, %d %b %Y %T %z')
YEAR = 2018

dist: README.md ChangeLog AUTHORS

togit: clean README.md
	git add .
	git push origin

AUTHORS: authors.in
	sed s/@mail@/$(mail)/g $^ > $@


README.md: README INSTALL
	cat README INSTALL > README.md
	@echo
	@echo Now you can make install or make some package
	sed -i "s|@executable_name@|$(EXECUTABLE_NAME)|g" $@
	sed -i "s|@version@|$(VERSION)|g" $@

ChangeLog: changelog.in
	@echo "$(EXECUTABLE_NAME) ($(VERSION)) unstable; urgency=medium" > $@
	@echo >> $@
	@echo "  * Local build." >> $@
	@echo >> $@
	@echo " -- $(AUTHOR) <$(MAIL)>  $(TIMESTAMP)" >> $@
	@echo >> $@
	@cat $^ >> $@
	sed -i "s|@mail@|$(MAIL)|g" $@

version_update: purge README.md ChangeLog

install: dist
	install -dm 755 $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	cp -r src/* $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	chown -R root:root $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	chmod -R u=rwX,go=rX $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	install -Dm644 LICENSE $(DESTDIR)/$(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/LICENSE
	install -Dm644 AUTHORS $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/AUTHORS
	install -Dm644 ChangeLog $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/ChangeLog
	install -Dm644 README.md $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/README
	install -Dm644 FAQ $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/FAQ

uninstall:
	rm -f $(PREFIX)/share/aurorae/themes/retrosmart-*
	rm -f $(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/
	rm -rf $(PREFIX)/share/doc/$(EXECUTABLE_NAME)/

clean: arch_clean debian_clean ocs_clean
	rm -rf ChangeLog README.md AUTHORS

debian:
	mkdir debian

debian/compat:
	echo 9 > $@

debian/rules: rules debian
	cp rules $@

debian/changelog: ChangeLog debian
	cp ChangeLog $@

debian/control: control debian
	sed s/@mail@/$(MAIL)/g control > $@

debian/README: README.md debian
	cp README.md debian/README

debian/copyright: copyright debian
	@echo Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/ > $@
	@echo Upstream-Name: $(EXECUTABLE_NAME) >> $@
	@echo "Upstream-Contact: Manuel Domínguez López <$(MAIL)>" >> $@
	@echo Source: $(SOURCE) >> $@
	@echo License: $(LICENSE) >> $@
	@echo >> $@
	@echo 'Files: *' >> $@
	@echo "Copyright: $(YEAR) $(AUTHOR) <$(MAIL)>" >> $@
	@echo License: $(LICENSE) >> $@
	cat copyright >> $@

debian_pkg: clean debian/compat debian/control debian/rules debian/changelog debian/README
	#fakeroot debian/rules clean
	#fakeroot debian/rules build
	fakeroot debian/rules binary
	mv ../$(EXECUTABLE_NAME)_$(VERSION)_all.deb .
	@echo Package done!
	@echo You can install it as root with:
	@echo dpkg -i $(EXECUTABLE_NAME)_$(VERSION)_all.deb

debian_clean:
	rm -rf debian $(EXECUTABLE_NAME)_$(VERSION)_all.deb

arch_pkg: clean ChangeLog
	sed -i "s|pkgname=.*|pkgname=$(EXECUTABLE_NAME)|" PKGBUILD
	sed -i "s|pkgver=.*|pkgver=$(VERSION)|" PKGBUILD
	sed -i "s|pkgdesc=.*|pkgdesc=\'$(DESCRIPTION)\'|" PKGBUILD
	sed -i "s|url=.*|url=$(URL)|" PKGBUILD
	makepkg
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $(EXECUTABLE_NAME)-$(VERSION)-1-any.pkg.tar.xz

arch_clean:
	rm -rf pkg $(EXECUTABLE_NAME) $(EXECUTABLE_NAME)-$(VERSION)-1-any.pkg.tar.xz

ocs_pkg: clean ChangeLog
	cd src; for i in *; do tar cJf $$i.tar.xz $$i;mv $$i.tar.xz ..; done

ocs_clean:
	rm -f retrosmart-*.tar.xz

user_install:
	cp -r src/retrosmart-* $$HOME/.local/share/aurorae/themes/

user_uninstall:
	rm -rf $$HOME/.local/share/aurorae/themes/retrosmart-*
