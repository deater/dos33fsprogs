HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite

all:	rain_sprites.inc

rain_sprites.inc:	rain_sprites.png
	$(HGR_SPRITE) -l splash_sprite0 rain_sprites.png 112 73 125 82 > rain_sprites.inc
	$(HGR_SPRITE) -l splash_sprite1 rain_sprites.png 126 73 139 82 >> rain_sprites.inc
	$(HGR_SPRITE) -l splash_sprite2 rain_sprites.png 140 73 153 82 >> rain_sprites.inc
	$(HGR_SPRITE) -l splash_sprite3 rain_sprites.png 154 73 167 82 >> rain_sprites.inc


clean:
	rm -f *~ \
		rain_sprites.inc

