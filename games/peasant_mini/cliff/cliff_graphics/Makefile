include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	cliff_base.hgr.zx02 cliff_base_priority.zx02

####

cliff_base.hgr.zx02:	cliff_base.hgr
	$(ZX02) cliff_base.hgr cliff_base.hgr.zx02

cliff_base.hgr:	cliff_base.png
	$(PNG_TO_HGR) cliff_base.png > cliff_base.hgr

####

cliff_base_priority.zx02:	cliff_base_priority.gr
	$(ZX02) -f cliff_base_priority.gr cliff_base_priority.zx02

cliff_base_priority.gr:	cliff_base_priority.png
	$(PNG2GR) cliff_base_priority.png cliff_base_priority.gr

####

clean:
	rm -f *~ *.o *.zx02 *.lst peasant_robe_sprites.inc
