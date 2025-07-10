include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	target_bg.hgr.zx02

####

target_bg.hgr.zx02:	target_bg.hgr
	$(ZX02) target_bg.hgr target_bg.hgr.zx02

target_bg.hgr:	target_bg.png
	$(PNG_TO_HGR) target_bg.png > target_bg.hgr

####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr

