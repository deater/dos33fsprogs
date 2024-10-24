include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	CREDITS

####

CREDITS:	credits.o
	ld65 -o CREDITS credits.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

credits.o:	credits.s vertical_scroll.s \
	font_4am_1x8.s ./fonts/font_4am_1x8_data.s \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o credits.o credits.s -l credits.lst

###

#graphics/summary1_invert.hgr.zx02:	
#	cd graphics && make

###

clean:
		rm -f *~ *.o *.lst CREDITS


