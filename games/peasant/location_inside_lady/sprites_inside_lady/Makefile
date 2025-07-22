HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	lady_cottage_sprites.inc

lady_cottage_sprites.inc:	lady_cottage_sprites.png
	$(HGR_SPRITE) -s -l lady_rock0 lady_cottage_sprites.png 98  127 118 160 > lady_cottage_sprites.inc
	$(HGR_SPRITE) -s -l lady_rock1 lady_cottage_sprites.png 126 127 146 160 >> lady_cottage_sprites.inc
	$(HGR_SPRITE) -s -l lady_rock2 lady_cottage_sprites.png 154 127 174 160 >> lady_cottage_sprites.inc
	$(HGR_SPRITE) -s -l chair0 lady_cottage_sprites.png  98  63 118  92 >> lady_cottage_sprites.inc
	$(HGR_SPRITE) -s -l chair1 lady_cottage_sprites.png 126  63 146  92 >> lady_cottage_sprites.inc
	$(HGR_SPRITE) -s -l chair2 lady_cottage_sprites.png 154  63 174  92 >> lady_cottage_sprites.inc



clean:
	rm -f *~ lady_cottage_sprites.inc
