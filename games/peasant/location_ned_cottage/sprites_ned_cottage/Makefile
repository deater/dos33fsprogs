HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	ned_sprites.inc

ned_sprites.inc:	ned_sprites.png
	$(HGR_SPRITE) -s -l rock_moved_sprite ned_sprites.png  7   1 27   12 > ned_sprites.inc
clean:
	rm -f *~ ned_sprites.inc

