include Makefile.inc

all:
	cd asoft_basic-utils && make
	cd asoft_presenter && make
	cd dos33fs-utils && make
	cd hgr-utils && make
	cd gr-utils && make

install:
	cd asoft_basic-utils && make install
	cd asoft_presenter && make install
	cd dos33fs-utils && make install
	cd hgr-utils && make install
	cd gr-utils && make install

clean:
	cd asoft_basic-utils && make clean
	cd asoft_presenter && make clean
	cd dos33fs-utils && make clean
	cd hgr-utils && make clean
	cd gr-utils && make clean
	rm -f *~

test:
