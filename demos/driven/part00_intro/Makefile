include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	INTRO

####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

intro.o:	intro.s \
	../zx02_optim.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/desire.hgr.zx02
	ca65 -o intro.o intro.s -l intro.lst

###

graphics/intro2.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst INTRO
	cd graphics && make clean
