include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	spheres.hgr.zx02 spheres.gr.zx02 long_sword.inc

####

spheres.gr.zx02:	spheres.gr
	$(ZX02) spheres.gr spheres.gr.zx02

spheres.gr:	spheres_lores.png
	$(PNG2GR) spheres_lores.png spheres.gr


####

spheres.hgr:	spheres.png
	$(PNG_TO_HGR) spheres.png > spheres.hgr

spheres.hgr.zx02:	spheres.hgr
	$(ZX02) spheres.hgr spheres.hgr.zx02

####

long_sword.inc:	sprite_skewed1.png sprite_skewed2.png sprite_skewed3.png
	$(PNG2SPRITES) sprite_skewed1.png long_sword1   0    0 6 48 >  long_swords.inc
	$(PNG2SPRITES) sprite_skewed2.png long_sword2   0    0 6 48 >>  long_swords.inc
	$(PNG2SPRITES) sprite_skewed3.png long_sword3   0    0 6 48 >>  long_swords.inc



####

clean:
	rm -f *~
