HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	archery_sprites.inc

archery_sprites.inc:	archery_sprites.png
	$(HGR_SPRITE) -s -l mendelev1_sprite archery_sprites.png  7   29 20 33 > archery_sprites.inc

clean:
	rm -f *~ archery_sprites.inc
