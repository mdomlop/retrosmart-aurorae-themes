PREFIX='/usr'
DESTDIR=''
PROGRAM_NAME := Retrosmart Aurorae themes
EXECUTABLE_NAME := retrosmart-aurorae-themes
DESCRIPTION := A retrosmart look collection of themes for KDE Aurorae.
VERSION := 0.2a
AUTHOR := Manuel Domínguez López
MAIL := mdomlop@gmail.com
LICENSE := GPLv3+
TIMESTAMP = $(shell LC_ALL=C date '+%a, %d %b %Y %T %z')
TEMPDIR := $(shell mktemp -u --suffix .$(EXECUTABLE_NAME))

ChangeLog: changelog.in
	@echo "$(EXECUTABLE_NAME) ($(VERSION)) unstable; urgency=medium" > $@
	@echo >> $@
	@echo "  * Git build." >> $@
	@echo >> $@
	@echo " -- $(AUTHOR) <$(MAIL)>  $(TIMESTAMP)" >> $@
	@echo >> $@
	@cat $^ >> $@

install:
	install -dm 755 $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	cp -r src/* $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	chown -R root:root $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	chmod -R u=rwX,go=rX $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	install -Dm644 LICENSE $(DESTDIR)/$(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/LICENSE
	install -Dm644 AUTHORS $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/AUTHORS
	install -Dm644 ChangeLog $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/ChangeLog
	install -Dm644 README.md $(DESTDIR)/$(PREFIX)/share/doc/$(EXECUTABLE_NAME)/README

uninstall: service-down
	rm -f $(PREFIX)/share/aurorae/themes/retrosmart-*
	rm -f $(PREFIX)/share/licenses/$(EXECUTABLE_NAME)/
	rm -rf $(PREFIX)/share/doc/$(EXECUTABLE_NAME)/

clean:
	rm -rf *.xz *.gz *.pot po/*.mo *.tgz *.deb *.rpm ChangeLog /tmp/tmp.*.$(EXECUTABLE_NAME) debian/changelog debian/README debian/files debian/$(EXECUTABLE_NAME) debian/debhelper-build-stamp debian/$(EXECUTABLE_NAME)*

deb: ChangeLog
	cp README.md debian/README
	cp ChangeLog debian/changelog
	#fakeroot debian/rules clean
	#fakeroot debian/rules build
	fakeroot debian/rules binary
	mv ../$(EXECUTABLE_NAME)_$(VERSION)_all.deb .
	@echo Package done!
	@echo You can install it as root with:
	@echo dpkg -i $(EXECUTABLE_NAME)_$(VERSION)_all.deb

pacman: clean
	mkdir $(TEMPDIR)
	tar cf $(TEMPDIR)/$(EXECUTABLE_NAME).tar ../$(EXECUTABLE_NAME)
	cp packages/pacman/local/PKGBUILD $(TEMPDIR)/
	cd $(TEMPDIR); makepkg
	cp $(TEMPDIR)/$(EXECUTABLE_NAME)-*.pkg.tar.xz .
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $(EXECUTABLE_NAME)-*.pkg.tar.xz
