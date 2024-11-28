include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG2DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	videlectrix.gr.zx02 \
	gameplay.gr.zx02 \
	title.hgr.zx02 \
	title.dhgr.aux.zx02 \
	title.dhgr.bin.zx02


####

sundae_sprites.inc:	a2_sundae_sprites.png a2_sundae_masks.png
	$(PNG2SPRITES) a2_sundae_sprites.png tree1_sprite   0 0 6 20 >  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_sprites.png tree2_sprite   7 0 5 18 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_sprites.png cherry_sprite 13 0 3 12 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_sprites.png sundae1_sprite 0 24 15 24 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_masks.png tree1_mask   0 0 6 20 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_masks.png tree2_mask   7 0 5 18 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_masks.png cherry_mask 13 0 3 12 >>  sundae_sprites.inc
	$(PNG2SPRITES) a2_sundae_masks.png sundae1_mask 0 24 15 24 >>  sundae_sprites.inc

####

title.hgr.zx02:	title.hgr
	$(ZX02) title.hgr title.hgr.zx02

title.hgr:	title.hgr.png
	$(PNG2HGR) title.hgr.png > title.hgr

####

title.dhgr.aux.zx02:	title.dhgr.AUX
	$(ZX02) title.dhgr.AUX title.dhgr.aux.zx02

title.dhgr.bin.zx02:	title.dhgr.BIN
	$(ZX02) title.dhgr.BIN title.dhgr.bin.zx02

title.dhgr.AUX:	title.dhgr.png
	$(PNG2DHGR) title.dhgr.png title.dhgr


####

videlectrix.gr.zx02:	videlectrix.gr
	$(ZX02) videlectrix.gr videlectrix.gr.zx02

videlectrix.gr:	videlectrix.png
	$(PNG2GR) videlectrix.png videlectrix.gr

####

gameplay.gr.zx02:	gameplay.gr
	$(ZX02) gameplay.gr gameplay.gr.zx02

gameplay.gr:	gameplay.png
	$(PNG2GR) gameplay.png gameplay.gr


####

clean:
	rm -f *~ *.o *.lst *.zx02 *.gr *.inc

