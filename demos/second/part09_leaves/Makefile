include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	LEAVES

####

LEAVES:	leaves.o
	ld65 -o LEAVES leaves.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

leaves.o:	leaves.s \
	../zx02_optim.s \
	../hgr_copy_fast.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/final3.hgr.zx02
	ca65 -o leaves.o leaves.s -l leaves.lst

###

graphics/final3.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst LEAVES
	cd graphics && make clean
