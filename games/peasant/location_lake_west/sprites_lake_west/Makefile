HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	bubble_sprites_w.inc \
	pebbles_sprites.inc \
	throw_sprites.inc

bubble_sprites_w.inc:	bubble_sprites_w.png
	$(HGR_SPRITE) -s -l bubble_sprite0 bubble_sprites_w.png 7 1  13 6 > bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite1 bubble_sprites_w.png 7 8  13 13 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite2 bubble_sprites_w.png 7 15 13 20 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite3 bubble_sprites_w.png 7 22 13 27 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite4 bubble_sprites_w.png 7 29 13 34 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite5 bubble_sprites_w.png 7 36 13 41 >> bubble_sprites_w.inc

pebbles_sprites.inc:	pebbles_sprites.png
	$(HGR_SPRITE) -s -l no_pebbles pebbles_sprites.png 84 100  111 112 > pebbles_sprites.inc

throw_sprites.inc:	throw.png
	$(HGR_SPRITE) -l throw_sprite0  throw.png   7 34  20 64 > throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite1  throw.png  35 34  48 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite2  throw.png  63 34  76 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite3  throw.png  91 34 104 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite4  throw.png 119 34 132 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite5  throw.png 140 34 153 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite6  throw.png 168 34 188 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite7  throw.png 196 34 216 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite8  throw.png 231 34 251 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite9  throw.png 203 127 223 157 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite10 throw.png 245 127 265 157 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask0  throw.png   7 65  20 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask1  throw.png  35 65  48 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask2  throw.png  63 65  76 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask3  throw.png  91 65 104 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask4  throw.png 119 65 132 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask5  throw.png 140 65 153 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask6  throw.png 168 65 188 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask7  throw.png 196 65 216 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask8  throw.png 231 65 251 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask9  throw.png 203 158 223 188 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask10 throw.png 245 158 265 188 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite0  throw.png  7 165  20 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite1  throw.png 28 162  41 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite2  throw.png 49 162  62 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite3  throw.png 70 162  83 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask0  throw.png  7 178  20 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask1  throw.png 28 175  41 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask2  throw.png 49 175  62 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask3  throw.png 70 175  83 187 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite0  throw.png  91 161 118 171 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite1  throw.png 126 161 153 171 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite2  throw.png 161 161 188 171 >> throw_sprites.inc







clean:
	rm -f *~ bubble_sprites_w.inc pebbles_sprites.inc throw_sprites.inc

