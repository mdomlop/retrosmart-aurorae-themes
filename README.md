![preview](https://github.com/mdomlop/retrosmart-aurorae-themes/blob/master/preview.png "Retrosmart Aurorae themes")

Retrosmart Aurorae themes
=========================

A retrosmart look collection of themes for KDE Aurorae.

Installation
------------

### Only for local user installation

Direct installation

        make user_install
        
Uninstall

        make user_clean
        
Install from OCS package
    
        make ocs_install

Uninstall

        make ocs_uninstall

### System-wide installation

Classic method:

        # make install
    
Uninstall

        # make uninstall

For Debian package manager:

- Build and install:

        $ make debian_pkg
        # dpkg -i retrosmart-aurorae-themes_1.1a_all.deb

- Uninstall:

        # apt purge retrosmart-aurorae-themes

For Arch linux:

- Build and install:

        $ make arch_pkg
        # pacman -U retrosmart-aurorae-themes-1.1a-1-any.pkg.tar.xz

- Uninstall:

        # pacman -Rsc retrosmart-aurorae-themes
