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
	dsr_logo.bin.zx02 dsr_logo.aux.zx02
	ca65 -o intro.o intro.s -l intro.lst

####

dsr_logo.aux.zx02:     dsr_logo.AUX
	$(ZX02) dsr_logo.AUX dsr_logo.aux.zx02

dsr_logo.AUX:  dsr_logo.png
	$(PNG_TO_DHGR) dsr_logo.png dsr_logo

dsr_logo.bin.zx02:     dsr_logo.BIN
	$(ZX02) dsr_logo.BIN dsr_logo.bin.zx02

dsr_logo.BIN: dsr_logo.png
	$(PNG_TO_DHGR) dsr_logo.png dsr_logo


####

clean:
	rm -f *~ INTRO *.zx02 *.lst *.o *.AUX *.BIN
