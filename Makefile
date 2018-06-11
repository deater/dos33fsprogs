include Makefile.inc

all:
	cd asoft_basic-utils && make
	cd asoft_presenter && make
	cd dos33fs-utils && make
	cd hgr-utils && make
	cd gr-utils && make
	cd mode7 && make
	cd mode7_demo && make
	cd still_alive && make
	cd tfv && make
	cd two-liners && make

install:
	cd asoft_basic-utils && make install
	cd asoft_presenter && make install
	cd dos33fs-utils && make install
	cd hgr-utils && make install
	cd gr-utils && make install
	cd mode7 && make install
	cd mode7_demo && make install
	cd still_alive && make install
	cd tfv && make install
	cd two-liners && make install

clean:
	cd asoft_basic-utils && make clean
	cd asoft_presenter && make clean
	cd dos33fs-utils && make clean
	cd hgr-utils && make clean
	cd gr-utils && make clean
	cd mode7 && make clean
	cd mode7_demo && make clean
	cd still_alive && make clean
	cd tfv && make clean
	cd two-liners && make clean
	rm -f *~

test:
