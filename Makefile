# This software is a part of the A.O.D (https://apprepo.de) project
# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
PWD:=$(shell pwd)

all: 

	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0

	wget --output-document="$(PWD)/build/OnlyOffice.AppImage" "http://download.onlyoffice.com/install/desktop/editors/linux/DesktopEditors-x86_64.AppImage"
	chmod +x $(PWD)/build/OnlyOffice.AppImage
		
	cd $(PWD)/build && $(PWD)/build/OnlyOffice.AppImage --appimage-extract

	rm -f $(PWD)/build/squashfs-root/asc-de.png
	rm -f $(PWD)/build/squashfs-root/usr/share/metainfo/desktopeditors.appdata.xml

	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib/x86_64-linux-gnu/*  $(PWD)/build/squashfs-root/usr/lib/

	rm -f $(PWD)/build/Boilerplate.AppDir/lib64/x86_64-linux-gnu
	rm -rf $(PWD)/build/squashfs-root/usr/lib/x86_64-linux-gnu
	
	ln -s $(PWD)/build/squashfs-root/usr/lib64									$(PWD)/build/squashfs-root/usr/lib/x86_64-linux-gnu


	cp --force --recursive $(PWD)/build/Boilerplate.AppDir/lib64/* 				$(PWD)/build/squashfs-root/usr/lib
	cp --force --recursive $(PWD)/build/Boilerplate.AppDir/share/* 				$(PWD)/build/squashfs-root/usr/share

	cp --force $(PWD)/AppDir/onlyoffice.svg 							$(PWD)/build/squashfs-root/asc-de.svg

	export ARCH=x86_64 && bin/appimagetool.AppImage 	$(PWD)/build/squashfs-root $(PWD)/OnlyOffice.AppImage
	chmod +x $(PWD)/OnlyOffice.AppImage

clean:
	rm -rf $(PWD)/build

