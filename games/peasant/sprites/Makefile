HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	inventory_sprites.inc ending_sprites.inc trogdor_sprites.inc \
	boat_sprites.inc peasant_sprites.inc ned_sprites.inc \
	peasant_robe_sprites.inc kerrek_sprites.inc \
	waterfall_sprites.inc bubble_sprites_w.inc bubble_sprites_e.inc \
	river_bubble_sprites.inc gary_sprites.inc

peasant_sprites.inc:	peasant_sprites.png
	$(HGR_SPRITE) -l peasant_right1_sprite peasant_sprites.png  35   1 35 29 > peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_right1_mask   peasant_sprites.png  21   1 21 29 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_sprite peasant_sprites.png  35  34 35 62 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_mask   peasant_sprites.png  21  34 21 62 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_sprite    peasant_sprites.png  35  68 35 96 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_mask      peasant_sprites.png  21  68 21 96 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_sprite    peasant_sprites.png  35 102 35 130 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_mask      peasant_sprites.png  21 102 21 130 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_sprite  peasant_sprites.png  84   1 90 29 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_mask    peasant_sprites.png  70   1 76 29 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_sprite  peasant_sprites.png  84  34 90 62 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_mask    peasant_sprites.png  70  34 76 62 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_sprite  peasant_sprites.png  84  68 90 96 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_mask    peasant_sprites.png  70  68 76 96 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_sprite  peasant_sprites.png  84 102 90 130 >> peasant_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_mask    peasant_sprites.png  70 102 76 130 >> peasant_sprites.inc

peasant_robe_sprites.inc:	peasant_sprites.png
	$(HGR_SPRITE) -l peasant_right1_sprite peasant_sprites.png  133   1 133 29 > peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right1_mask   peasant_sprites.png  119   1 119 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_sprite peasant_sprites.png  133  34 133 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_right2_mask   peasant_sprites.png  119  34 119 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_sprite    peasant_sprites.png  133  68 133 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up1_mask      peasant_sprites.png  119  68 119 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_sprite    peasant_sprites.png  133 102 133 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_up2_mask      peasant_sprites.png  119 102 119 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_sprite  peasant_sprites.png  182   1 188 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left1_mask    peasant_sprites.png  168   1 174 29 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_sprite  peasant_sprites.png  182  34 188 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_left2_mask    peasant_sprites.png  168  34 174 62 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_sprite  peasant_sprites.png  182  68 188 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down1_mask    peasant_sprites.png  168  68 174 96 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_sprite  peasant_sprites.png  182 102 188 130 >> peasant_robe_sprites.inc
	$(HGR_SPRITE) -l peasant_down2_mask    peasant_sprites.png  168 102 174 130 >> peasant_robe_sprites.inc




boat_sprites.inc:	boat_sprites.png
	$(HGR_SPRITE) -s -l boat0 boat_sprites.png  7   1 81   45 > boat_sprites.inc
	$(HGR_SPRITE) -s -l boat1 boat_sprites.png  7  47 81   91 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat2 boat_sprites.png  7  93 81  137 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat3 boat_sprites.png  7 139 81  183 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat4 boat_sprites.png 91   1 165  45 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat5 boat_sprites.png 91  47 165  91 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat6 boat_sprites.png 91  93 165 137 >> boat_sprites.inc
	$(HGR_SPRITE) -s -l boat7 boat_sprites.png 91 139 165 183 >> boat_sprites.inc

ned_sprites.inc:	ned_sprites.png
	$(HGR_SPRITE) -s -l rock_moved_sprite ned_sprites.png  7   1 27   12 > ned_sprites.inc

gary_sprites.inc:	gary_sprites.png
	$(HGR_SPRITE) -s -l gary_base_sprite gary_sprites.png   21  98 55   124 > gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly1_sprite gary_sprites.png   63  98 76   117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_fly2_sprite gary_sprites.png   91  98 104  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail1_sprite gary_sprites.png 119  98 132  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_tail2_sprite gary_sprites.png 147  98 160  117 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot0_sprite gary_sprites.png  63 118  76  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot1_sprite gary_sprites.png  91 118 104  128 >> gary_sprites.inc
	$(HGR_SPRITE) -s -l gary_foot2_sprite gary_sprites.png 119 118 132  128 >> gary_sprites.inc

inventory_sprites.inc:	inventory.png
	$(HGR_SPRITE) -l arrow_sprite inventory.png 14 3 27 19 > inventory_sprites.inc
	$(HGR_SPRITE) -l baby_sprite inventory.png 14 20 27 36 >> inventory_sprites.inc
	$(HGR_SPRITE) -l kerrek_belt_sprite inventory.png 14 37 27 53 >> inventory_sprites.inc
	$(HGR_SPRITE) -l chicken_feed_sprite inventory.png 14 54 27 70 >> inventory_sprites.inc
	$(HGR_SPRITE) -l bow_sprite inventory.png 14 71 27 87 >> inventory_sprites.inc
	$(HGR_SPRITE) -l mask_sprite inventory.png 14 88 27 104 >> inventory_sprites.inc
	$(HGR_SPRITE) -l pebbles_sprite inventory.png 14 105 27 121 >> inventory_sprites.inc
	$(HGR_SPRITE) -l pills_sprite inventory.png 14 122 27 138 >> inventory_sprites.inc
	$(HGR_SPRITE) -l riches_sprite inventory.png 14 139 27 155 >> inventory_sprites.inc
	$(HGR_SPRITE) -l robe_sprite inventory.png 42 3 55 19 >> inventory_sprites.inc
	$(HGR_SPRITE) -l soda_sprite inventory.png 42 20 55 36 >> inventory_sprites.inc
	$(HGR_SPRITE) -l sub_sprite inventory.png 42 37 55 53 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trinket_sprite inventory.png 42 54 55 70 >> inventory_sprites.inc
	$(HGR_SPRITE) -l troghelm_sprite inventory.png 42 71 55 87 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trogshield_sprite inventory.png 42 88 55 104 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trogsword_sprite inventory.png 42 105 55 121 >> inventory_sprites.inc
#	$(HGR_SPRITE) -l no_sprite inventory.png 42 122 55 138 >> inventory_sprites.inc
	$(HGR_SPRITE) -l tshirt_sprite inventory.png 42 139 55 155 >> inventory_sprites.inc


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

kerrek_sprites.inc:	kerrek_sprites.png
	$(HGR_SPRITE) -s -l kerrek_l1_sprite kerrek_sprites.png 14 2 27 53 > kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l1_head_sprite kerrek_sprites.png 7 6 13 14 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l2_sprite kerrek_sprites.png 49 2 62 53 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l2_head_sprite kerrek_sprites.png 42 6 48 12 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r1_sprite kerrek_sprites.png 7 56 20 108 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r1_head_sprite kerrek_sprites.png 21 60 27 68 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r2_sprite kerrek_sprites.png 42 56 55 108 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r2_head_sprite kerrek_sprites.png 56 60 62 66 >> kerrek_sprites.inc

trogdor_sprites.inc:	trogdor_sprites.png
	$(HGR_SPRITE) -s -l dashing0_sprite trogdor_sprites.png 14 6 20 45 > trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing1_sprite trogdor_sprites.png 28 6 34 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing2_sprite trogdor_sprites.png 42 6 48 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing3_sprite trogdor_sprites.png 56 6 62 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing4_sprite trogdor_sprites.png 70 6 76 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing5_sprite trogdor_sprites.png 84 6 90 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing6_sprite trogdor_sprites.png 98 6 104 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing7_sprite trogdor_sprites.png 112 6 118 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l dashing8_sprite trogdor_sprites.png 126 6 132 45 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_r1_sprite trogdor_sprites.png 14 49 20 54 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_r2_sprite trogdor_sprites.png 28 49 34 54 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_l1_sprite trogdor_sprites.png 14 56 20 61 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l tiny_l2_sprite trogdor_sprites.png 28 56 34 61 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword1_sprite trogdor_sprites.png 42 48 48 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword2_sprite trogdor_sprites.png 49 48 55 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword3_sprite trogdor_sprites.png 56 48 62 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword4_sprite trogdor_sprites.png 63 48 69 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword5_sprite trogdor_sprites.png 70 48 76 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sword6_sprite trogdor_sprites.png 77 48 83 53 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l smoke1_sprite trogdor_sprites.png 14 62 20 69 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l smoke2_sprite trogdor_sprites.png 28 62 34 69 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l smoke3_sprite trogdor_sprites.png 42 62 48 69 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l smoke4_sprite trogdor_sprites.png 56 62 62 69 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l smoke5_sprite trogdor_sprites.png 70 62 76 69 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sleep1_sprite trogdor_sprites.png 14 70 27 79 >> trogdor_sprites.inc
	$(HGR_SPRITE) -s -l sleep2_sprite trogdor_sprites.png 28 70 41 79 >> trogdor_sprites.inc

waterfall_sprites.inc:	waterfall_sprites.png
	$(HGR_SPRITE) -s -l waterfall_sprite waterfall_sprites.png 14 5 27 52 > waterfall_sprites.inc

bubble_sprites_w.inc:	bubble_sprites_w.png
	$(HGR_SPRITE) -s -l bubble_sprite0 bubble_sprites_w.png 7 1  13 6 > bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite1 bubble_sprites_w.png 7 8  13 13 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite2 bubble_sprites_w.png 7 15 13 20 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite3 bubble_sprites_w.png 7 22 13 27 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite4 bubble_sprites_w.png 7 29 13 34 >> bubble_sprites_w.inc
	$(HGR_SPRITE) -s -l bubble_sprite5 bubble_sprites_w.png 7 36 13 41 >> bubble_sprites_w.inc

bubble_sprites_e.inc:	bubble_sprites_e.png
	$(HGR_SPRITE) -s -l bubble_e_sprite0 bubble_sprites_e.png 7 1  13 6 > bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite1 bubble_sprites_e.png 7 8  13 13 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite2 bubble_sprites_e.png 7 15 13 20 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite3 bubble_sprites_e.png 7 22 13 27 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite4 bubble_sprites_e.png 7 29 13 34 >> bubble_sprites_e.inc
	$(HGR_SPRITE) -s -l bubble_e_sprite5 bubble_sprites_e.png 7 36 13 41 >> bubble_sprites_e.inc

river_bubble_sprites.inc:	river_bubble_sprites.png
	$(HGR_SPRITE) -s -l bubble_r_sprite0 river_bubble_sprites.png 7 1  13 6 > river_bubble_sprites.inc
	$(HGR_SPRITE) -s -l bubble_r_sprite1 river_bubble_sprites.png 7 8  13 13 >> river_bubble_sprites.inc

clean:
	rm -f *~ peasant_sprites.inc inventory_sprites.inc \
		ending_sprites.inc trogdor_sprites.inc ned_sprites.inc \
		peasant_robe_sprites.inc kerrek_sprites.inc \
		waterfall_sprites.inc bubble_sprites_w.inc \
		bubble_sprites_e.inc river_bubble_sprites.inc \
		gary_sprites.inc
