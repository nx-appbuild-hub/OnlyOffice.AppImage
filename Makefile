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
