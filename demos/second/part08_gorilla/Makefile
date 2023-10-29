include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	GORILLA

####

GORILLA:	gorilla.o
	ld65 -o GORILLA gorilla.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

gorilla.o:	gorilla.s \
	../zx02_optim.s \
	../hgr_copy_fast.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/mntscrl3.hgr.zx02
	ca65 -o gorilla.o gorilla.s -l gorilla.lst

###

graphics/mntscrl3.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst GORILLA
	cd graphics && make clean
