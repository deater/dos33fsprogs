HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	boat_sprites.inc boat_sprites_fish.inc bubble_sprites_e.inc

boat_sprites.inc:	boat_sprites.png
#	$(HGR_SPRITE) -s -l boat0 boat_sprites.png  7   1 81   45 > boat_sprites.inc
#	$(HGR_SPRITE) -s -l boat1 boat_sprites.png  7  47 81   91 >> boat_sprites.inc
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

clean:
	rm -f *~ \
		boat_sprites.inc boat_sprites_fish.inc \
		bubble_sprites_e.inc

