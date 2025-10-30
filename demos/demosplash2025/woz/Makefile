include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	WOZ

###

WOZ:	woz.o
	ld65 -o WOZ woz.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

woz.o:	woz.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	martymation.s \
	graphics/nine_woz.raw_top.zx02 graphics/nine_woz.raw_bottom.zx02 \
	graphics/asteroid_page1.hgr.zx02
	ca65 -o woz.o woz.s -l woz.lst

####

graphics/nine_woz.raw_top.zx02:	
	cd graphics && make


####

clean:
	rm -f *~ WOZ *.zx02 *.lst *.o *.AUX *.BIN

distclean:
	rm -f *~ WOZ *.zx02 *.lst *.o *.AUX *.BIN
	cd graphics && make clean

