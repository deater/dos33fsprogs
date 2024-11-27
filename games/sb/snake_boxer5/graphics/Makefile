include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	videlectrix.gr.zx02 \
	gameplay.gr.zx02

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

