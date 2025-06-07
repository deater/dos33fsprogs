HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	waterfall_sprites.inc

waterfall_sprites.inc:	waterfall_sprites.png
	$(HGR_SPRITE) -s -l waterfall_sprite waterfall_sprites.png 14 5 27 52 > waterfall_sprites.inc

clean:
	rm -f *~ \
		waterfall_sprites.inc
