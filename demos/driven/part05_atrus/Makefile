include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

all:	ATRUS

###

ATRUS:	atrus.o
	ld65 -o ATRUS atrus.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

atrus.o:	atrus.s \
	plasma.s do_plasma.s init_plasma.s \
	../zp.inc ../hardware.inc ../common_defines.inc ../qload.inc \
	graphics/atrus03_iipix.hgr.zx02 \
	graphics/atrus10_iipix.hgr.zx02 \
	graphics/atrus11_iipix.hgr.zx02 \
	font/large_font.inc \
	big_horiz_scroll.s horiz_scroll.s
	ca65 -o atrus.o atrus.s -l atrus.lst


###

font/large_font.inc:
	cd font && make

graphics/atrus03_iipix.hgr.zx02:
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst ATRUS

