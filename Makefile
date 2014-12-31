#
# Makefile - for the tma-unix-runtime
#
# The current default install site is /opt/tma since we do NOT want
# to overwrite currentlt installed versions of TCL/TK etc. This meets
# the UNIX File System Hierachy standards. 
#

# default install is into /opt/tma
# at this stage we do NOT clean /opt/tma out 

PREFIX= /opt/tma

TARBALLS= \
	tcl8.5.14-src.tar.gz  \
	tk8.5.14-src.tar.gz \
	bwidget-1.9.6.tar.gz  \
	tcllib-1.15.tar.gz \
	tklib-0.6.tar.gz

ZIPS=	blt-src-2.5.3.zip

.PHONY: all all2 extract compile rminstall tcl tk blt tklib tcllib wize clean \
	unix-run wine-run chmod

all:
	echo "Building runtime to $(PREFIX)"
	echo "Is it ok to rm -rf $(PREFIX) and reinstall?"
	echo "ok (c-c to exit)" ; read x
	sudo make all2

all2:	extract compile chmod

chmod:
	find $(PREFIX) -type d -exec chmod 0755 {} \;

extract:
	cd imports; sha256sum --check SHA256SUMS 
	-rm -rf build
	mkdir build
	cd build ; \
	for f in $(TARBALLS) ; \
	do tar zxvf ../imports/$$f ; \
	done ; \
	for f in $(ZIPS) ; \
	do unzip ../imports/$$f ; \
	done ; 

compile: rminstall tcl tk blt tklib tcllib 

rminstall:
	-rm -rf install

tcl:	
	cd build/tcl8*/unix ; \
	  ./configure --enable-symbols --prefix=$(PREFIX) ; \
	  make ; make install


tk:
	cd build/tk8*/unix ; \
	  ./configure --enable-symbols --prefix=$(PREFIX); \
	  make ; make install

blt:
	cd build/blt2.5 ; \
	  ./configure --enable-symbols --prefix=$(PREFIX); \
	  make ; make install

tklib:
	cd build/tklib* ; \
	  ./configure --prefix=$(PREFIX) ; \
	  make install

tcllib:	
	cd build/Tcllib* ; \
	  ./configure --prefix=$(PREFIX) ; \
	  make install


clean:
	rm -rf build runtime 






