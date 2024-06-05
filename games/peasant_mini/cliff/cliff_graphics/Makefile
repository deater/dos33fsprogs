include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	cliff_base.hgr.zx02 peasant_robe_sprites.inc \
	cliff_base_priority.zx02

####

peasant_robe_sprites.inc:	peasant_sprites.png
	$(HGR_SPRITE) -l peasant_right1_sprite peasant_sprites.png  133   1 133 29 > peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right1_mask   peasant_sprites.png  119   1 119 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_sprite peasant_sprites.png  133  34 133 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_mask   peasant_sprites.png  119  34 119 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_sprite    peasant_sprites.png  133  68 133 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_mask      peasant_sprites.png  119  68 119 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_sprite    peasant_sprites.png  133 102 133 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_mask      peasant_sprites.png  119 102 119 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_sprite  peasant_sprites.png  182   1 188 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_mask    peasant_sprites.png  168   1 174 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_sprite  peasant_sprites.png  182  34 188 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_mask    peasant_sprites.png  168  34 174 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_sprite  peasant_sprites.png  182  68 188 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_mask    peasant_sprites.png  168  68 174 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_sprite  peasant_sprites.png  182 102 188 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_mask    peasant_sprites.png  168 102 174 130 >> peasant_robe_sprites.inc

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
