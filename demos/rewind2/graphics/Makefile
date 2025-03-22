include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	headphone.aux.zx02 headphone.bin.zx02

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
	rm -f *~ *.zx02
