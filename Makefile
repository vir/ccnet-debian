ARCHIVE=CruiseControl.NET-1.8.5.0.zip

.PHONY:	download unpack patch
all:	download unpack patch

download: $(ARCHIVE)

unpack: license.txt

$(ARCHIVE):
	wget https://downloads.sourceforge.net/project/ccnet/CruiseControl.NET%20Releases/CruiseControl.NET%201.8.5/$(ARCHIVE)

license.txt: $(ARCHIVE)
	unzip -o $(ARCHIVE)

patch:
	find . -name '*.config' -exec perl -pi -e 's/\\/\//sg' {} \;

install: CCCmd CCTray CCValidator examples license.txt Server WebDashboard
	mkdir -p ${DESTDIR}/opt/ccnet
	mv $^ ${DESTDIR}/opt/ccnet/
	/usr/bin/install lighttpd.conf ${DESTDIR}/etc/lighttpd/conf-available/50-ccnet.conf

