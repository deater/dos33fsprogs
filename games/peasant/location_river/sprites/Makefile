HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	river_bubble_sprites.inc

river_bubble_sprites.inc:	river_bubble_sprites.png
	$(HGR_SPRITE) -s -l bubble_r_sprite0 river_bubble_sprites.png 7 1  13 6 > river_bubble_sprites.inc
	$(HGR_SPRITE) -s -l bubble_r_sprite1 river_bubble_sprites.png 7 8  13 13 >> river_bubble_sprites.inc

clean:
	rm -f *~ \
		river_bubble_sprites.inc
