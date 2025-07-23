HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	flame_sprites.inc

flame_sprites.inc:	flame_sprites.png
	$(HGR_SPRITE) -s -l flame0 flame_sprites.png  77 118  90 125 > flame_sprites.inc
	$(HGR_SPRITE) -s -l flame1 flame_sprites.png  77 131  90 138 >> flame_sprites.inc
	$(HGR_SPRITE) -s -l flame2 flame_sprites.png  77 143  90 150 >> flame_sprites.inc
	$(HGR_SPRITE) -s -l flame3 flame_sprites.png  77 155  90 162 >> flame_sprites.inc

clean:
	rm -f *~ \
		flame_sprites.inc


