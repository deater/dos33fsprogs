HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	mud_sprites.inc

mud_sprites.inc:	mud.png
	$(HGR_SPRITE) -s -l mud_sprite0 mud.png  77 126 188 140 > mud_sprites.inc
	$(HGR_SPRITE) -s -l mud_sprite1 mud.png  77 140 188 154 >> mud_sprites.inc

clean:
	rm -f *~ mud_sprites.inc
