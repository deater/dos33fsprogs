HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	drawer_sprites.inc

drawer_sprites.inc:	drawer_sprites.png
	$(HGR_SPRITE) -s -l drawer_closed_sprite drawer_sprites.png 154 98 202 117 > drawer_sprites.inc
	$(HGR_SPRITE) -s -l drawer_open_robe_sprite drawer_sprites.png 154 126 202 145 >> drawer_sprites.inc
	$(HGR_SPRITE) -s -l drawer_open_no_robe_sprite drawer_sprites.png  154 150 202 169 >> drawer_sprites.inc

clean:
	rm -f *~ drawer_sprites.inc

