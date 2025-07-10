HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bow_sprites.inc

bow_sprites.inc:	bow_sprites.png
	$(HGR_SPRITE) -s -l bow_sprite0 bow_sprites.png  21 159  76 183 > bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite1 bow_sprites.png  77 159 125 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite2 bow_sprites.png 126 159 174 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite3 bow_sprites.png 175 159 230 183 >> bow_sprites.inc


clean:	
	rm -f *~ bow_sprites.inc

