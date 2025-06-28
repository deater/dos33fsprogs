HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	boat_sprites.inc boat_sprites_fish.inc bubble_sprites_e.inc \
	throw_sprites.inc

boat_sprites.inc:	boat_sprites.png
	$(HGR_SPRITE) -s -l boat0 boat_sprites.png  7  19 62   45 > boat_sprites.inc
	$(HGR_SPRITE) -s -l boat1 boat_sprites.png  7  65 62   90 >> boat_sprites.inc

boat_sprites_fish.inc:	boat_sprites.png
	$(HGR_SPRITE) -s -l boat2 boat_sprites.png  7  93 81  137 > boat_sprites_fish.inc
	$(HGR_SPRITE) -s -l boat3 boat_sprites.png  7 139 81  183 >> boat_sprites_fish.inc
	$(HGR_SPRITE) -s -l boat4 boat_sprites.png 91   1 165  45 >> boat_sprites_fish.inc
	$(HGR_SPRITE) -s -l boat5 boat_sprites.png 91  47 165  91 >> boat_sprites_fish.inc
	$(HGR_SPRITE) -s -l boat6 boat_sprites.png 91  93 165 137 >> boat_sprites_fish.inc
	$(HGR_SPRITE) -s -l boat7 boat_sprites.png 91 139 165 183 >> boat_sprites_fish.inc

bubble_sprites_e.inc:	bubble_sprites_e.png
	$(HGR_SPRITE) -s -l bubble_e_sprite0 bubble_sprites_e.png 7 1  13 6 > bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite1 bubble_sprites_e.png 7 8  13 13 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite2 bubble_sprites_e.png 7 15 13 20 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite3 bubble_sprites_e.png 7 22 13 27 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite4 bubble_sprites_e.png 7 29 13 34 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite5 bubble_sprites_e.png 7 36 13 41 >> bubble_sprites_e.inc

throw_sprites.inc:	throw_sprites.png
	$(HGR_SPRITE) -l throw_sprite0 throw_sprites.png 182 128 195 158 > throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite1 throw_sprites.png 154 128 167 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite2 throw_sprites.png 126 128 139 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite3 throw_sprites.png  98 128 111 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite4 throw_sprites.png  70 128  83 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite5 throw_sprites.png  42 128  55 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_sprite6 throw_sprites.png  14 128  27 158 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask0   throw_sprites.png 182 159 195 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask1   throw_sprites.png 154 159 167 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask2   throw_sprites.png 126 159 139 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask3   throw_sprites.png  98 159 111 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask4   throw_sprites.png  70 159  83 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask5   throw_sprites.png  42 159  55 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l throw_mask6   throw_sprites.png  14 159  27 189 >> throw_sprites.inc
	$(HGR_SPRITE) -l feed_sprite0 throw_sprites.png 210  32 223 42 >> throw_sprites.inc
	$(HGR_SPRITE) -l feed_sprite1 throw_sprites.png 238  32 251 43 >> throw_sprites.inc
	$(HGR_SPRITE) -l feed_sprite2 throw_sprites.png 210 128 223 138 >> throw_sprites.inc
	$(HGR_SPRITE) -l feed_sprite3 throw_sprites.png 238 128 251 136 >> throw_sprites.inc



clean:
	rm -f *~ \
		boat_sprites.inc boat_sprites_fish.inc \
		bubble_sprites_e.inc throw_sprites.inc

