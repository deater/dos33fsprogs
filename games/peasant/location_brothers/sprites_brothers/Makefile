HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	archery_sprites.inc

archery_sprites.inc:	archery_sprites.png
	$(HGR_SPRITE) -s -l mendelev0_sprite archery_sprites.png 203  5 216 20 > archery_sprites.inc
	$(HGR_SPRITE) -s -l mendelev1_sprite archery_sprites.png 203 47 216 62 >> archery_sprites.inc
	$(HGR_SPRITE) -s -l dongolev0_sprite archery_sprites.png 238  3 251 19 >> archery_sprites.inc
	$(HGR_SPRITE) -s -l dongolev1_sprite archery_sprites.png 238 45 251 61 >> archery_sprites.inc


clean:
	rm -f *~ archery_sprites.inc
