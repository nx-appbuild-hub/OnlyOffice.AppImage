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
SOURCE="http://download.onlyoffice.com/install/desktop/editors/linux/DesktopEditors-x86_64.AppImage"
DESTINATION="OnlyOffice.AppImage"

all:
	echo "Building: $(OUTPUT)"
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION)  --continue $(SOURCE)
	chmod +x $(DESTINATION)
	./$(DESTINATION) --appimage-extract
	rm -f squashfs-root/asc-de.png
	rm -f squashfs-root/usr/share/metainfo/desktopeditors.appdata.xml
	cp icon.svg squashfs-root/asc-de.svg
	export ARCH=x86_64 && bin/appimagetool.AppImage squashfs-root $(DESTINATION)
	rm -rf squashfs-root
	chmod +x $(DESTINATION)
