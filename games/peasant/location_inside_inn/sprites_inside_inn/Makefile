HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper_sprites.inc

keeper_sprites.inc:	inside_inn_sprites.png
	$(HGR_SPRITE) -s -l keeper0 inside_inn_sprites.png  70 60  97 79 > keeper_sprites.inc
	$(HGR_SPRITE) -s -l keeper1 inside_inn_sprites.png 112 60 139 79 >> keeper_sprites.inc
	$(HGR_SPRITE) -s -l keeper2 inside_inn_sprites.png 154 60 181 79 >> keeper_sprites.inc
	$(HGR_SPRITE) -s -l keeper3 inside_inn_sprites.png 196 60 223 79 >> keeper_sprites.inc


clean:
	rm -f *~ \
		keeper_sprites.inc


