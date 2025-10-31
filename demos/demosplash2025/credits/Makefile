include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	CREDITS.zx02

####

CREDITS.zx02:	CREDITS
	$(ZX02) CREDITS CREDITS.zx02

CREDITS:	credits.o
	ld65 -o CREDITS credits.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

credits.o:	credits.s vertical_scroll.s \
	font_4am_1x8_oneline.s\
	./fonts/font_4am_1x8_data.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	graphics/keeper1_sprites.inc graphics/other_sprites.inc
	ca65 -o credits.o credits.s -l credits.lst

###

graphics/keeper1_sprites.inc:	
	cd graphics && make

###

clean:
	rm -f *~ *.o *.lst *.zx02 CREDITS generate_scroll

distclean:
	rm -f *~ *.o *.lst *.zx02 CREDITS generate_scroll
	cd graphics && make clean

