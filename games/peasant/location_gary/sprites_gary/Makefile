HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	gary_sprites.inc

gary_sprites.inc:	gary_sprites.png
	$(HGR_SPRITE) -s -l gary_base_sprite gary_sprites.png   21  98 55   124 > gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly1_sprite gary_sprites.png   63  98 76   117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly2_sprite gary_sprites.png   91  98 104  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail1_sprite gary_sprites.png 119  98 132  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail2_sprite gary_sprites.png 147  98 160  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot0_sprite gary_sprites.png  63 118  76  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot1_sprite gary_sprites.png  91 118 104  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot2_sprite gary_sprites.png 119 118 132  128 >> gary_sprites.inc

clean:
	rm -f *~ gary_sprites.inc
