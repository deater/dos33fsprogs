HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	river_bubble_sprites.inc river_current_sprites.inc river_night_sprites.inc

river_bubble_sprites.inc:	river_bubble_sprites.png
	$(HGR_SPRITE) -s -l bubble_r_sprite0 river_bubble_sprites.png 7 1  13 6 > river_bubble_sprites.inc
	$(HGR_SPRITE) -s -l bubble_r_sprite1 river_bubble_sprites.png 7 8  13 13 >> river_bubble_sprites.inc

river_current_sprites.inc:	river_current_sprites.png
	$(HGR_SPRITE) -s -l current_sprite0 river_current_sprites.png 28 102  83 135 > river_current_sprites.inc
	$(HGR_SPRITE) -s -l current_sprite1 river_current_sprites.png 28 143  83 176 >> river_current_sprites.inc

river_night_sprites.inc:	river_night_sprites.png
	$(HGR_SPRITE) -s -l current_night_sprite0 river_night_sprites.png 28 102  83 135 > river_night_sprites.inc
	$(HGR_SPRITE) -s -l current_night_sprite1 river_night_sprites.png 28 143  83 176 >> river_night_sprites.inc


clean:
	rm -f *~ \
		river_bubble_sprites.inc river_night_sprites.inc \
		river_current_sprites.inc
