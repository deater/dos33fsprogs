include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	NUTS

####

NUTS:	nuts.o
	ld65 -o NUTS nuts.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

nuts.o:	nuts.s \
	../zx02_optim.s \
	../zp.inc ../hardware.inc ../qload2.inc \
	graphics/fc_iipix.hgr.zx02 \
	graphics/ship_sprites.inc
	ca65 -o nuts.o nuts.s -l nuts.lst

###

graphics/fc_iipix.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst NUTS
	cd graphics && make clean
