HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bubble_sprites_w.inc \
	pebbles_sprites.inc

bubble_sprites_w.inc:	bubble_sprites_w.png
	$(HGR_SPRITE) -s -l bubble_sprite0 bubble_sprites_w.png 7 1  13 6 > bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite1 bubble_sprites_w.png 7 8  13 13 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite2 bubble_sprites_w.png 7 15 13 20 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite3 bubble_sprites_w.png 7 22 13 27 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite4 bubble_sprites_w.png 7 29 13 34 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite5 bubble_sprites_w.png 7 36 13 41 >> bubble_sprites_w.inc

pebbles_sprites.inc:	pebbles_sprites.png
	$(HGR_SPRITE) -s -l no_pebbles pebbles_sprites.png 84 100  111 112 > pebbles_sprites.inc

clean:
	rm -f *~ bubble_sprites_w.inc pebbles_sprites.inc

