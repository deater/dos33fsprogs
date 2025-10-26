include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	INTRO EXTRA

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	extra.inc \
	fx.dhgr.redlines.s \
	graphics/logo_grafA.bin.zx02 graphics/logo_grafA.aux.zx02 \
	graphics/logo_dSr_D2.bin.zx02 graphics/logo_dSr_D2.aux.zx02 \
	graphics/ms_title.hgr.zx02 graphics/house_sprites.inc
	ca65 -o intro.o intro.s -l intro.lst

###

EXTRA:	extra.o
	ld65 -o EXTRA extra.o -C $(LINKER_SCRIPTS)/apple2_a000.inc

extra.o:	extra.s \
	graphics/logo_grafA.bin.zx02 \
	graphics/ms_title.hgr.zx02
	ca65 -o extra.o extra.s -l extra.lst

extra.inc:	EXTRA
	../generate_common -a 0xa000 -s title_hgr extra.lst > extra.inc
	../generate_common -a 0xa000 -s logo1_main extra.lst >> extra.inc


####

graphics/ms_title.hgr.zx02:	
	cd graphics && make

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
	rm -f *~ INTRO EXTRA *.zx02 *.lst *.o *.AUX *.BIN extra.inc

distclean:
	rm -f *~ INTRO EXTRA *.zx02 *.lst *.o *.AUX *.BIN
	cd graphics && make clean
