HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	knight_sprites.inc

knight_sprites.inc:	knight_sprites.png
	$(HGR_SPRITE) -s -l bubble_r_sprite0 knight_sprites.png 7 1  13 6 > knight_sprites.inc
	$(HGR_SPRITE) -s -l bubble_r_sprite1 knight_sprites.png 7 8  13 13 >> knight_sprites.inc

clean:
	rm -f *~ \
		knight_sprites.inc
