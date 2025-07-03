HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	well_sprites.inc

well_sprites.inc:	well_sprites.png
	$(HGR_SPRITE) -l bucket0_sprite well_sprites.png 154  13 181  31  > well_sprites.inc
	$(HGR_SPRITE) -l bucket1_sprite well_sprites.png 154  34 181  52 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket2_sprite well_sprites.png 154  55 181  73 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket3_sprite well_sprites.png 154  76 181  94 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket0_mask   well_sprites.png 196  13 223  31 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket1_mask   well_sprites.png 196  34 223  52 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket2_mask   well_sprites.png 196  55 223  73 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket3_mask   well_sprites.png 196  76 223  94 >> well_sprites.inc
	$(HGR_SPRITE) -l mask0_sprite   well_sprites.png 154  97 181 115 >> well_sprites.inc
	$(HGR_SPRITE) -l mask1_sprite   well_sprites.png 154 118 181 136 >> well_sprites.inc
	$(HGR_SPRITE) -l mask2_sprite   well_sprites.png 154 139 181 157 >> well_sprites.inc
	$(HGR_SPRITE) -l mask3_sprite   well_sprites.png 154 160 181 178 >> well_sprites.inc
	$(HGR_SPRITE) -l mask0_mask     well_sprites.png 196  97 223 115 >> well_sprites.inc
	$(HGR_SPRITE) -l mask1_mask     well_sprites.png 196 118 223 136 >> well_sprites.inc
	$(HGR_SPRITE) -l mask2_mask     well_sprites.png 196 139 223 157 >> well_sprites.inc
	$(HGR_SPRITE) -l mask3_mask     well_sprites.png 196 160 223 178 >> well_sprites.inc
	$(HGR_SPRITE) -l crank0_sprite  well_sprites.png 252  16 265  28 >> well_sprites.inc
	$(HGR_SPRITE) -l crank1_sprite  well_sprites.png 252  37 265  49 >> well_sprites.inc
	$(HGR_SPRITE) -l crank2_sprite  well_sprites.png 252  58 265  70 >> well_sprites.inc
	$(HGR_SPRITE) -l crank0_mask    well_sprites.png 252  79 265  91 >> well_sprites.inc
	$(HGR_SPRITE) -l crank1_mask    well_sprites.png 252 100 265 112 >> well_sprites.inc
	$(HGR_SPRITE) -l crank2_mask    well_sprites.png 252 121 265 133 >> well_sprites.inc




clean:
	rm -f *~ well_sprites.inc
