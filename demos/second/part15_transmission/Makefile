include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	SPHERES

####

SPHERES:	spheres.o
	ld65 -o SPHERES spheres.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

spheres.o:	spheres.s \
	../zx02_optim.s \
	../hgr_copy_fast.s \
	../audio.s \
	../zp.inc ../hardware.inc ../qload.inc \
	audio/transmission.btc.zx02 \
	graphics/spheres.hgr.zx02
	ca65 -o spheres.o spheres.s -l spheres.lst

###

graphics/spheres.hgr.zx02:	
	cd graphics && make

audio/transmission.btc.zx02:
	cd audio && make
###


clean:
	rm -f *~ *.o *.lst SPHERES
	cd graphics && make clean
	cd audio && make clean
