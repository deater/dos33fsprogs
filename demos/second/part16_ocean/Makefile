include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	OCEAN

####

OCEAN:	ocean.o
	ld65 -o OCEAN ocean.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

ocean.o:	ocean.s ../zx02_optim.s \
	graphics/frame00000002.hgr.zx02 \
	graphics/frame00000003.hgr.zx02 \
	graphics/frame00000004.hgr.zx02 \
	graphics/frame00000005.hgr.zx02 \
	graphics/frame00000006.hgr.zx02 \
	graphics/frame00000007.hgr.zx02 \
	graphics/frame00000024.hgr.zx02 \
	graphics/frame00000025.hgr.zx02 \
	graphics/frame00000026.hgr.zx02 \
	graphics/frame00000027.hgr.zx02 \
	graphics/frame00000028.hgr.zx02 \
	graphics/frame00000029.hgr.zx02 \
	graphics/frame00000030.hgr.zx02 \
	graphics/frame00000031.hgr.zx02 \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o ocean.o ocean.s -l ocean.lst

###


clean:
		rm -f *~ *.o *.lst OCEAN
