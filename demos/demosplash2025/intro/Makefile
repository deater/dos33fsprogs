include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	INTRO

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	fx.dhgr.redlines.s \
	graphics/logo_grafA.bin.zx02 graphics/logo_grafA.aux.zx02 \
	graphics/logo_dSr_D2.bin.zx02 graphics/logo_dSr_D2.aux.zx02
	ca65 -o intro.o intro.s -l intro.lst

####

graphics/logo_grafA.aux.zx02:	
	cd graphics && make

graphics/logo_grafA.bin.zx02:	
	cd graphics && make

graphics/logo_dSr_D2.aux.zx02:	
	cd graphics && make

graphics/logo_dSr_D2.bin.zx02:	
	cd graphics && make

####

clean:
	rm -f *~ INTRO *.zx02 *.lst *.o *.AUX *.BIN

distclean:
	rm -f *~ INTRO *.zx02 *.lst *.o *.AUX *.BIN
	cd graphics && make clean
