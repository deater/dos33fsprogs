HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	ned_sprites.inc

ned_sprites.inc:	ned_sprites.png
	$(HGR_SPRITE) -s -l ned1_sprite ned_sprites.png  28  110 41 121 > ned_sprites.inc
	$(HGR_SPRITE) -s -l ned2_sprite ned_sprites.png  28  128 41 154 >> ned_sprites.inc
	$(HGR_SPRITE) -s -l ned3_sprite ned_sprites.png  7   157 41 184 >> ned_sprites.inc

clean:
	rm -f *~ ned_sprites.inc

