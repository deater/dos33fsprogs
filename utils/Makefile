include ../Makefile.inc

all:
	cd asoft_basic-utils && make
	cd asoft_presenter && make
	cd asoft_sound && make
	cd bmp2dhr && make
#	cd dos33fs-linux2.4 && make
	cd dos33fs-utils && make
#	cd gr-sim && make
	cd gr-utils && make
	cd hgr-utils && make

install:
	cd asoft_basic-utils && make install
	cd asoft_presenter && make install
	cd asoft_sound && make install
#	cd bmp2dhr && make install
#	cd dos33fs-linux2.4 && make install
	cd dos33fs-utils && make install
#	cd gr-sim && make install
	cd gr-utils && make install
	cd hgr-utils && make install

clean:
	cd asoft_basic-utils && make clean
	cd asoft_presenter && make clean
	cd asoft_sound && make clean
	cd bmp2dhr && make clean
	cd dos33fs-linux2.4 && make clean
	cd dos33fs-utils && make clean
	cd gr-sim && make clean
	cd gr-utils && make clean
	cd hgr-utils && make clean
	rm -f *~

test:
