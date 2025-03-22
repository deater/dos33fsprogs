include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	HEADPHONES

###

HEADPHONES:	headphones.o
	ld65 -o HEADPHONES headphones.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

headphones.o:	headphones.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	headphone.bin.zx02 headphone.aux.zx02
	ca65 -o headphones.o headphones.s -l headphones.lst

####

headphone.aux.zx02:     headphone.AUX
	$(ZX02) headphone.AUX headphone.aux.zx02

headphone.AUX:  headphone.png
	$(PNG_TO_DHGR) headphone.png headphone

headphone.bin.zx02:     headphone.BIN
	$(ZX02) headphone.BIN headphone.bin.zx02

headphone.BIN: headphone.png
	$(PNG_TO_DHGR) headphone.png headphone


####

clean:
	rm -f *~ HEADPHONES *.zx02
