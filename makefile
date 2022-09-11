PREFIX='/usr'
DESTDIR=''

HNAME := $(shell grep ^HNAME INFO | cut -d= -f2)
PKGNAME := $(shell grep ^PKGNAME INFO | cut -d= -f2)
AUTHOR := $(shell grep ^AUTHOR INFO | cut -d= -f2)
VERSION := $(shell grep ^VERSION INFO | cut -d= -f2)
LICENSE := $(shell grep ^LICENSE INFO | cut -d= -f2)
DESCRIPTION := $(shell grep ^DESCRIPTION INFO | cut -d= -f2)
URL := $(shell grep ^URL INFO | cut -d= -f2)
MAIL := $(shell grep ^MAIL INFO | cut -d= -f2 | tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
YEAR := $(shell grep ^YEAR INFO | cut -d= -f2)

TIMESTAMP = $(shell LC_ALL=C date '+%a, %d %b %Y %T %z')

PKGEXT=pkg.tar.zst
ARCHPKG = $(PKGNAME)-$(VERSION)-1-any.$(PKGEXT)

DEBIANDIR = $(PKGNAME)-$(VERSION)_all
DEBIANPKG = $(DEBIANDIR).deb


BASENAME = retrosmart
THEMES = $(notdir $(basename $(wildcard src/*.mk)))

dist: $(THEMES) README.md ChangeLog AUTHORS

include src/*.mk


install: dist
	install -dm 755 $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	cp -r retrosmart-* $(DESTDIR)/$(PREFIX)/share/aurorae/themes/
	chown -R root:root $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	chmod -R u=rwX,go=rX $(DESTDIR)/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	install -Dm644 LICENSE $(DESTDIR)/$(PREFIX)/share/licenses/$(PKGNAME)/LICENSE
	install -Dm644 AUTHORS $(DESTDIR)/$(PREFIX)/share/doc/$(PKGNAME)/AUTHORS
	install -Dm644 ChangeLog $(DESTDIR)/$(PREFIX)/share/doc/$(PKGNAME)/ChangeLog
	install -Dm644 README.md $(DESTDIR)/$(PREFIX)/share/doc/$(PKGNAME)/README

uninstall:
	rm -f $(PREFIX)/share/aurorae/themes/retrosmart-*
	rm -f $(PREFIX)/share/licenses/$(PKGNAME)/
	rm -rf $(PREFIX)/share/doc/$(PKGNAME)/

clean:
	rm -rf retrosmart-*/

purge: clean clean_arch clean_debian clean_ocs


debian/copyright: copyright debian
	@echo Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/ > $@
	@echo Upstream-Name: $(PKGNAME) >> $@
	@echo "Upstream-Contact: Manuel Domínguez López <$(MAIL)>" >> $@
	@echo Source: $(SOURCE) >> $@
	@echo License: $(LICENSE) >> $@
	@echo >> $@
	@echo 'Files: *' >> $@
	@echo "Copyright: $(YEAR) $(AUTHOR) <$(MAIL)>" >> $@
	@echo License: $(LICENSE) >> $@
	cat copyright >> $@

pkg_debian: $(DEBIANPKG) 
$(DEBIANPKG): $(DEBIANDIR) 
$(DEBIANDIR): purge dist control ChangeLog README.md
	install -dm 755 DEBIANTEMP/$(PREFIX)/share/aurorae/themes/
	cp -r retrosmart-* DEBIANTEMP/$(PREFIX)/share/aurorae/themes/
	#chown -R root:root DEBIANTEMP/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	chmod -R u=rwX,go=rX DEBIANTEMP/$(PREFIX)'/share/aurorae/themes'/retrosmart-*
	install -Dm644 LICENSE DEBIANTEMP/$(PREFIX)/share/licenses/$(PKGNAME)/LICENSE
	install -Dm644 AUTHORS DEBIANTEMP/$(PREFIX)/share/doc/$(PKGNAME)/AUTHORS
	install -Dm644 ChangeLog DEBIANTEMP/$(PREFIX)/share/doc/$(PKGNAME)/ChangeLog
	install -Dm644 README.md DEBIANTEMP/$(PREFIX)/share/doc/$(PKGNAME)/README
	sed -i "s/Installed-Size:.*/Installed-Size:\ $$(du -ks DEBIANTEMP | cut -f1)/" control
	mv DEBIANTEMP $@
	mkdir -p -m 0775 $@/DEBIAN
	@sed s/@mail@/$(MAIL)/g control > $@/DEBIAN/control
	cp ChangeLog $@/DEBIAN
	cp README.md $@/DEBIAN/README
	dpkg-deb --build --root-owner-group $@

clean_debian:
	rm -rf DEBIAN $(DEBIANDIR) $(DEBIANPKG).deb

pkg_arch: $(ARCHPKG)
$(ARCHPKG): PKGBUILD makefile LICENSE README.md
	sed -i "s|pkgname=.*|pkgname=$(PKGNAME)|" PKGBUILD
	sed -i "s|pkgver=.*|pkgver=$(VERSION)|" PKGBUILD
	sed -i "s|pkgdesc=.*|pkgdesc='$(DESCRIPTION)'|" PKGBUILD
	sed -i "s|url=.*|url='$(URL)'|" PKGBUILD
	sed -i "s|license=.*|license=('$(LICENSE)')|" PKGBUILD
	makepkg -df PKGDEST=./ BUILDDIR=./ PKGEXT='.$(PKGEXT)'
	@echo
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $@

clean_arch:
	rm -rf pkg $(ARCHPKG)

pkg_ocs: clean dist
	#cd src; tar cJf ../$(PKGNAME).tar.xz retrosmart-*
	#for i in retrosmart-*; do tar cJf $$i.tar.xz $$i; done
	tar cJf $(PKGNAME).tar.xz retrosmart-*/

clean_ocs:
	rm -f retrosmart-*.tar.xz

user_install:
	cp -r src/retrosmart-* $$HOME/.local/share/aurorae/themes/

user_uninstall:
	rm -rf $$HOME/.local/share/aurorae/themes/retrosmart-*
