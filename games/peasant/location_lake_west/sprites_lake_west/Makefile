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
	$(HGR_SPRITE) -l throw_sprite0  throw.png  14 34  27 64 > throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite1  throw.png  42 34  55 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite2  throw.png  70 34  83 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite3  throw.png  98 34 111 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite4  throw.png 126 34 139 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite5  throw.png 154 34 167 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite6  throw.png 182 34 202 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite7  throw.png 210 34 230 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite8  throw.png 238 34 258 64 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite9  throw.png 210 127 230 157 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite10 throw.png 238 127 258 157 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask0  throw.png  14 65  27 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask1  throw.png  42 65  55 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask2  throw.png  70 65  83 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask3  throw.png  98 65 111 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask4  throw.png 126 65 139 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask5  throw.png 154 65 167 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask6  throw.png 182 65 202 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask7  throw.png 210 65 230 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask8  throw.png 238 65 258 95 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask9  throw.png 210 158 230 188 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask10 throw.png 238 158 258 188 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite0  throw.png 14 165  27 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite1  throw.png 42 162  55 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite2  throw.png 70 162  83 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_sprite3  throw.png 98 162 111 174 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask0  throw.png 14 178  27 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask1  throw.png 42 175  55 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask2  throw.png 70 175  83 187 >> throw_sprites.inc
	$(HGR_SPRITE) -l baby_mask3  throw.png 98 175 111 187 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite0  throw.png  91 161 118 171 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite1  throw.png 126 161 153 171 >> throw_sprites.inc
	$(HGR_SPRITE) -s -l swim_sprite2  throw.png 161 161 188 171 >> throw_sprites.inc







clean:
	rm -f *~ bubble_sprites_w.inc pebbles_sprites.inc throw_sprites.inc

