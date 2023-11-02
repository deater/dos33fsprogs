include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	lenspic.gr.zx02 lens_sprites.inc

####

lenspic.gr.zx02:	lenspic.gr
	$(ZX02) lenspic.gr lenspic.gr.zx02

lenspic.gr:	lenspic.png
	$(PNG2GR) lenspic.png lenspic.gr

####

lens_sprites.inc:	lens_sprites.png
	$(PNG2SPRITES) lens_sprites.png lens_sprite   0   0 11 24 >  lens_sprites.inc
	$(PNG2SPRITES) lens_sprites.png lens_mask    13   0 11 24 >>  lens_sprites.inc



####

clean:
	rm -f *~
