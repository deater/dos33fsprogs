include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../../linker_scripts/

all:	LENS

####

LENS:	lens.o
	ld65 -o LENS lens.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

lens.o:	lens.s ../zx02_optim.s \
	roto.s rotozoom.s \
	graphics/lenspic.gr.zx02 \
	../zp.inc ../hardware.inc
	ca65 -o lens.o lens.s -l lens.lst

###


graphics/lenspic.gr.zx02:	
	cd graphics && make

####

clean:
	rm -f *~ *.o *.lst LENS
	cd graphics && make clean
