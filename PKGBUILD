# Maintainer: Manuel Domínguez López <mdomlop at gmail dot com>

_pkgver_year=2019
_pkgver_month=10
_pkgver_day=20

pkgname=retrosmart-aurorae-themes
pkgver=1.5
pkgrel=1
pkgdesc='A retrosmart look collection of themes for KDE Aurorae.'
url='https://github.com/mdomlop/retrosmart-aurorae-themes'
source=()
license=('GPL-3')
optdepends=('retrosmart-kvantum-theme: The corresponding theme for Kvantum'
            'retrosmart-qtcurve-theme: The corresponding theme for QtCurve'
            'retrosmart-gtk-themes: The corresponding GTK themes'
            'retrosmart-openbox-themes: The corresponding Openbox themes'
            'retrosmart-wallpapers: The corresponding backgrounds project'
            'retrosmart-x11-cursors: The corresponding X11 cursor theme'
            'retrosmart-xfwm4-themes: The corresponding XFwm4 themes')
arch=('any')
group=('retrosmart')
changelog=ChangeLog


build() {
    cd "$startdir"
    make
    }

package() {
    cd "$startdir"
    make install DESTDIR=$pkgdir
}
