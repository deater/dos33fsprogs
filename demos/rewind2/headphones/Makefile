include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	HEADPHONES

###

HEADPHONES:	headphones.o
	ld65 -o HEADPHONES headphones.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

headphones.o:	headphones.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	headphones.bin.zx02 headphones.aux.zx02 \
	hip1.bin.zx02 hip1.aux.zx02 \
	hip2.bin.zx02 hip2.aux.zx02 \
	hip3.bin.zx02 hip3.aux.zx02
	ca65 -o headphones.o headphones.s -l headphones.lst

###

#HEADPHONES_MAIN:	headphones_main.o
#	ld65 -o HEADPHONES_MAIN headphones_main.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#headphones_main.o:	headphones_main.s \
#	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
#	headphones_aux.inc \
#	headphone.bin.zx02 \
#	hip1.bin.zx02 \
#	hip2.bin.zx02 \
#	hip3.bin.zx02
#	ca65 -o headphones_main.o headphones_main.s -l headphones_main.lst


###

headphones_aux.inc:	../generate_common HEADPHONES_AUX
	../generate_common -a 0x6000 -s headphone_aux headphones_aux.lst > headphones_aux.inc
	../generate_common -a 0x6000 -s hip1_aux headphones_aux.lst >> headphones_aux.inc
	../generate_common -a 0x6000 -s hip2_aux headphones_aux.lst >> headphones_aux.inc
	../generate_common -a 0x6000 -s hip3_aux headphones_aux.lst >> headphones_aux.inc




###

#HEADPHONES_AUX:	headphones_aux.o
#	ld65 -o HEADPHONES_AUX headphones_aux.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#headphones_aux.o:	headphones_aux.s \
#	headphone.aux.zx02 \
#	hip1.aux.zx02 \
#	hip2.aux.zx02 \
#	hip3.aux.zx02
#	ca65 -o headphones_aux.o headphones_aux.s -l headphones_aux.lst


####

headphones.aux.zx02:     headphones.AUX
	$(ZX02) headphones.AUX headphones.aux.zx02

headphones.AUX:  headphones.png
	$(PNG_TO_DHGR) headphones.png headphones

headphones.bin.zx02:     headphones.BIN
	$(ZX02) headphones.BIN headphones.bin.zx02

headphones.BIN: headphones.png
	$(PNG_TO_DHGR) headphones.png headphones

####

hip1.aux.zx02:     hip1.AUX
	$(ZX02) hip1.AUX hip1.aux.zx02

hip1.AUX:  hip1.png
	$(PNG_TO_DHGR) hip1.png hip1

hip1.bin.zx02:     hip1.BIN
	$(ZX02) hip1.BIN hip1.bin.zx02

hip1.BIN: hip1.png
	$(PNG_TO_DHGR) hip1.png hip1

####

hip2.aux.zx02:     hip2.AUX
	$(ZX02) hip2.AUX hip2.aux.zx02

hip2.AUX:  hip2.png
	$(PNG_TO_DHGR) hip2.png hip2

hip2.bin.zx02:     hip2.BIN
	$(ZX02) hip2.BIN hip2.bin.zx02

hip2.BIN: hip2.png
	$(PNG_TO_DHGR) hip2.png hip2

####

hip3.aux.zx02:     hip3.AUX
	$(ZX02) hip3.AUX hip3.aux.zx02

hip3.AUX:  hip3.png
	$(PNG_TO_DHGR) hip3.png hip3

hip3.bin.zx02:     hip3.BIN
	$(ZX02) hip3.BIN hip3.bin.zx02

hip3.BIN: hip3.png
	$(PNG_TO_DHGR) hip3.png hip3




####

clean:
	rm -f *~ HEADPHONES *.zx02
