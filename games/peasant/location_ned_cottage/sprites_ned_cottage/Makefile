HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	ned_sprites.inc baby_sprites.inc cottage_sprites.inc

# 84,98 ->132,133
# 84,98 -> 132,115
# 84,115 -> 132,133

ned_sprites.inc:	ned_sprites.png
	$(HGR_SPRITE) -s -l rock_moved_sprite ned_sprites.png 161 144 181 155 > ned_sprites.inc
	$(HGR_SPRITE) -s -l door_open_top_sprite ned_sprites.png   84  98 132 115 >> ned_sprites.inc
	$(HGR_SPRITE) -s -l door_open_bottom_sprite ned_sprites.png   84  115 132 133 >> ned_sprites.inc


	# 0 = small open (door closed)
	# 1 = medium open (door closed)
	# 2 = large open (door closed)
	# 3 = door part open
	# 4 = door full open (note, should we separate door and broom?)
	# 5 = medium open (door open)
	# 6 = small open (door closed)
	# 7 = close up small open

cottage_sprites.inc:	deploy1.png deploy2.png deploy3.png deploy4.png \
		deploy5.png deploy6.png deploy7.png deploy8.png
	$(HGR_SPRITE) -s -l wall_sprite0 deploy2.png 126 90 153 104 > cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite1 deploy3.png 119 82 160 120 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite2 deploy4.png  98 69 167 125 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite3 deploy5.png 105 98 132 132 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite4 deploy6.png  84 98 132 132 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite5 deploy7.png  98 69 167 125 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite6 deploy8.png 119 81 160 119 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l wall_sprite7 deploy1.png 126 90 153 104 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l broom_sprite0 deploy4.png 14 42  48  70 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l broom_sprite1 deploy4.png 14 77  48 105 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l broom_sprite2 deploy4.png 14 112 48 140 >> cottage_sprites.inc
	$(HGR_SPRITE) -s -l broom_sprite3 deploy4.png 14 147 48 175 >> cottage_sprites.inc




baby_sprites.inc:	baby_sprites.png
	$(HGR_SPRITE) -l baby_sprite0 baby_sprites.png  56  1 83  8 >  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite1 baby_sprites.png  56  9 83 16 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite2 baby_sprites.png  56 17 83 24 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite3 baby_sprites.png  56 25 83 32 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite4 baby_sprites.png  56 33 76 40 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite5 baby_sprites.png  56 41 76 48 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite6 baby_sprites.png  56 49 76 56 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite7 baby_sprites.png  56 57 76 64 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_sprite8 baby_sprites.png  56 65 69 72 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask0 baby_sprites.png  98  1 125  8 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask1 baby_sprites.png  98  9 125 16 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask2 baby_sprites.png  98 17 125 24 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask3 baby_sprites.png  98 25 125 32 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask4 baby_sprites.png  98 33 118 40 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask5 baby_sprites.png  98 41 118 48 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask6 baby_sprites.png  98 49 118 56 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask7 baby_sprites.png  98 57 118 64 >>  baby_sprites.inc
	$(HGR_SPRITE) -l baby_mask8 baby_sprites.png  98 65 111 72 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_sprite0 baby_sprites.png 56  77  83  84 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_sprite1 baby_sprites.png 56  85  83  92 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_sprite2 baby_sprites.png 56  93  83 100 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_sprite3 baby_sprites.png 56 101  83 108 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_sprite4 baby_sprites.png 56 109  76 116 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_mask0   baby_sprites.png 98  77 125  84 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_mask1   baby_sprites.png 98  85 125  92 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_mask2   baby_sprites.png 98  93 125 100 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_mask3   baby_sprites.png 98 101 125 108 >>  baby_sprites.inc
	$(HGR_SPRITE) -l fast_mask4   baby_sprites.png 98 109 118 116 >>  baby_sprites.inc




#baby_sprites.inc:	baby_sprites.png
#	$(HGR_SPRITE) -l baby1_sprite0 baby_sprites.png 168  1 195  9 >  baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite1 baby_sprites.png 168 10 195 18 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite2 baby_sprites.png 168 19 195 27 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite3 baby_sprites.png 168 28 188 36 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite4 baby_sprites.png 168 37 188 45 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite5 baby_sprites.png 168 46 188 54 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_sprite6 baby_sprites.png 168 55 181 63 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask0   baby_sprites.png 210  1 237  9 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask1   baby_sprites.png 210 10 237 18 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask2   baby_sprites.png 210 19 237 27 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask3   baby_sprites.png 210 28 230 36 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask4   baby_sprites.png 210 37 230 45 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask5   baby_sprites.png 210 46 230 54 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby1_mask6   baby_sprites.png 210 55 223 63 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite0 baby_sprites.png 168 70 195 78 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite1 baby_sprites.png 168 79 195 87 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite2 baby_sprites.png 168 88 195 96 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite3 baby_sprites.png 168 97 188 105 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite4 baby_sprites.png 168 106 188 114 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite5 baby_sprites.png 168 115 188 123 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_sprite6 baby_sprites.png 168 124 181 132 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask0   baby_sprites.png 210 70 237 78 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask1   baby_sprites.png 210 79 237 87 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask2   baby_sprites.png 210 88 237 96 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask3   baby_sprites.png 210 97 237 105 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask4   baby_sprites.png 210 106 230 114 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask5   baby_sprites.png 210 115 230 123 >> baby_sprites.inc
#	$(HGR_SPRITE) -l baby2_mask6   baby_sprites.png 210 124 230 132 >> baby_sprites.inc


clean:
	rm -f *~ ned_sprites.inc baby_sprites.inc cottage_sprites.inc

