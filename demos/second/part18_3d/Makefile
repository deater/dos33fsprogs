include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	THREED

####

THREED:	threed.o
	ld65 -o THREED threed.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

threed.o:	threed.s draw_boxes.s 3d.inc
	ca65 -o threed.o threed.s -l threed.lst

####

clean:
		rm -f *~ *.o *.lst HELLO THREED
