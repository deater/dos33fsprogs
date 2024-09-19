HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	ending_sprites.inc

ending_sprites.inc:	end_sprites.png end_boat_sprites.png
	$(HGR_SPRITE) -l baby0_sprite end_sprites.png 14 3 27 17 > ending_sprites.inc
	$(HGR_SPRITE) -l baby0_mask end_sprites.png 42 3 55 17 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby1_sprite end_sprites.png 14 20 27 34 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby1_mask end_sprites.png 42 20 55 34 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby2_sprite end_sprites.png 14 37 27 51 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby2_mask end_sprites.png 42 37 55 51 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby3_sprite end_sprites.png 14 54 27 68 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby3_mask end_sprites.png 42 54 55 68 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby4_sprite end_sprites.png 14 71 27 85 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby4_mask end_sprites.png 42 71 55 85 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby5_sprite end_sprites.png 14 88 27 102 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby5_mask end_sprites.png 42 88 55 102 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby6_sprite end_sprites.png 14 105 27 119 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby6_mask end_sprites.png 42 105 55 119 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby7_sprite end_sprites.png 14 122 27 136 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby7_mask end_sprites.png 42 122 55 136 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby8_sprite end_sprites.png 14 139 27 153 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby8_mask end_sprites.png 42 139 55 153 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby9_sprite end_sprites.png 14 156 27 170 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby9_mask end_sprites.png 42 156 55 170 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby10_sprite end_sprites.png 14 173 27 187 >> ending_sprites.inc
	$(HGR_SPRITE) -l baby10_mask end_sprites.png 42 173 55 187 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l jhonka1 end_sprites.png 105 84 145 115 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l jhonka2 end_sprites.png 105 121 145 152 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat0 end_boat_sprites.png  7   1 81   45 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat1 end_boat_sprites.png  7  47 81   91 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat2 end_boat_sprites.png  7  93 81  137 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat3 end_boat_sprites.png  7 139 81  183 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat4 end_boat_sprites.png 91   1 165  45 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat5 end_boat_sprites.png 91  47 165  91 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat6 end_boat_sprites.png 91  93 165 137 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l boat7 end_boat_sprites.png 91 139 165 183 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l foam0 end_sprites.png 155  38 165 85 >> ending_sprites.inc
	$(HGR_SPRITE) -s -l foam1 end_sprites.png 183  38 195 85 >> ending_sprites.inc

clean:
	rm -f *~ ending_sprites.inc
