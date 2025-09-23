HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	well_sprites.inc

well_sprites.inc:	well_sprites.png baby_sprites.png
	$(HGR_SPRITE) -l bucket0_sprite well_sprites.png 168  14 202  34  > well_sprites.inc
	$(HGR_SPRITE) -l bucket1_sprite well_sprites.png 168  35 202  55 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket2_sprite well_sprites.png 168  56 202  77 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket3_sprite well_sprites.png 168  77 202  97 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket0_mask   well_sprites.png 210  14 244  34 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket1_mask   well_sprites.png 210  35 244  55 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket2_mask   well_sprites.png 210  56 244  77 >> well_sprites.inc
	$(HGR_SPRITE) -l bucket3_mask   well_sprites.png 210  77 244  97 >> well_sprites.inc
	$(HGR_SPRITE) -l mask0_sprite   well_sprites.png 168 100 202 120 >> well_sprites.inc
	$(HGR_SPRITE) -l mask1_sprite   well_sprites.png 168 121 202 141 >> well_sprites.inc
	$(HGR_SPRITE) -l mask2_sprite   well_sprites.png 168 142 202 162 >> well_sprites.inc
	$(HGR_SPRITE) -l mask3_sprite   well_sprites.png 168 163 202 183 >> well_sprites.inc
	$(HGR_SPRITE) -l mask0_mask     well_sprites.png 210 100 244 120 >> well_sprites.inc
	$(HGR_SPRITE) -l mask1_mask     well_sprites.png 210 121 244 141 >> well_sprites.inc
	$(HGR_SPRITE) -l mask2_mask     well_sprites.png 210 142 244 162 >> well_sprites.inc
	$(HGR_SPRITE) -l mask3_mask     well_sprites.png 210 163 244 183 >> well_sprites.inc
	$(HGR_SPRITE) -l crank0_sprite  well_sprites.png 252  63 265  75 >> well_sprites.inc
	$(HGR_SPRITE) -l crank1_sprite  well_sprites.png 252  79 265  91 >> well_sprites.inc
	$(HGR_SPRITE) -l crank2_sprite  well_sprites.png 252  95 265 107 >> well_sprites.inc
	$(HGR_SPRITE) -l crank0_mask    well_sprites.png 252 112 265 124 >> well_sprites.inc
	$(HGR_SPRITE) -l crank1_mask    well_sprites.png 252 128 265 140 >> well_sprites.inc
	$(HGR_SPRITE) -l crank2_mask    well_sprites.png 252 144 265 156 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn0_sprite baby_sprites.png 168  14 202  34 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn1_sprite baby_sprites.png 168  35 202  55 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn2_sprite baby_sprites.png 168  56 202  77 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn3_sprite baby_sprites.png 168  77 202  97 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn0_mask   baby_sprites.png 210  14 244  34 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn1_mask   baby_sprites.png 210  35 244  55 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn2_mask   baby_sprites.png 210  56 244  77 >> well_sprites.inc
	$(HGR_SPRITE) -l babydn3_mask   baby_sprites.png 210  77 244  97 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup0_sprite baby_sprites.png 168 100 202 120 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup1_sprite baby_sprites.png 168 121 202 141 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup2_sprite baby_sprites.png 168 142 202 162 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup0_mask   baby_sprites.png 210 100 244 120 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup1_mask   baby_sprites.png 210 121 244 141 >> well_sprites.inc
	$(HGR_SPRITE) -l babyup2_mask   baby_sprites.png 210 142 244 162 >> well_sprites.inc

clean:
	rm -f *~ well_sprites.inc
