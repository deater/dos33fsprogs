include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

all:	ATRUS

###

ATRUS:	atrus.o
	ld65 -o ATRUS atrus.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

atrus.o:	atrus.s \
	../zp.inc ../hardware.inc \
	graphics/atrus03_iipix.hgr.zx02 \
	graphics/atrus10_iipix.hgr.zx02 \
	graphics/atrus11_iipix.hgr.zx02
	ca65 -o atrus.o atrus.s -l atrus.lst


###

graphics/tree01.gr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst ATRUS

