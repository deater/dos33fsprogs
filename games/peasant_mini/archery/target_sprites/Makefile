HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bow_sprites.inc

bow_sprites.inc:	bow_sprites.png
	$(HGR_SPRITE) -s -l bow_sprite_odd0 bow_sprites.png  21 159  76 183 > bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd1 bow_sprites.png  77 159 125 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd2 bow_sprites.png 126 159 174 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_odd3 bow_sprites.png 175 159 230 183 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd0 bow_sprites.png  42 183 125 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_odd1 bow_sprites.png 126 183 209 184 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even0 bow_sprites.png  14   7  69  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even1 bow_sprites.png  70   7 118  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even2 bow_sprites.png 119   7 167  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l bow_sprite_even3 bow_sprites.png 168   7 223  31 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even0 bow_sprites.png  35 31 118 32 >> bow_sprites.inc
	$(HGR_SPRITE) -s -l string_sprite_even1 bow_sprites.png 119 31 202 32 >> bow_sprites.inc

clean:	
	rm -f *~ bow_sprites.inc

