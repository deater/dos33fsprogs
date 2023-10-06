include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	a2_energy.hgr.zx02


####

a2_energy.hgr.zx02:	a2_energy.hgr
	$(ZX02) a2_energy.hgr a2_energy.hgr.zx02

a2_energy.hgr:	a2_energy.png
	$(PNG_TO_HGR) a2_energy.png > a2_energy.hgr

####

clean:
	rm -f *~ *.o *.zx02 *.lst
