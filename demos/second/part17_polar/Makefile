include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	POLAR

####

POLAR:	polar.o
	ld65 -o POLAR polar.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

polar.o:	polar.s \
	../zx02_optim.s \
	../hgr_copy_fast.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/polar2.hgr.zx02
	ca65 -o polar.o polar.s -l polar.lst

###

graphics/polar2.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst POLAR
	cd graphics && make clean
