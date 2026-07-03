HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	kerrek_sprites.inc kerrek_body_sprites.inc kerrek_belt.inc \
	kerrek_hit_sprites.inc

kerrek_sprites.inc:	kerrek_sprites.png
	$(HGR_SPRITE) -s -l kerrek_l1_sprite kerrek_sprites.png 14 2 27 53 > kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l1_head_sprite kerrek_sprites.png 7 6 13 14 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l2_sprite kerrek_sprites.png 49 2 62 53 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_l2_head_sprite kerrek_sprites.png 42 6 48 12 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r1_sprite kerrek_sprites.png 7 56 20 108 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r1_head_sprite kerrek_sprites.png 21 60 27 68 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r2_sprite kerrek_sprites.png 42 56 55 108 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r2_head_sprite kerrek_sprites.png 56 60 62 66 >> kerrek_sprites.inc
	# hitting animation
	$(HGR_SPRITE) -s -l kerrek_r_hitting_legs_sprite kerrek_sprites.png 70 23 83 54 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r_hitting_head_sprite kerrek_sprites.png 70 2 83 13 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r_hitting_teeth_sprite kerrek_sprites.png 84 10 90 12 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r_hitting_arm_sprite kerrek_sprites.png 98 13 118 23 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r_hitting_arm_up_sprite kerrek_sprites.png 126 0 146 23 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_r_hitting_arm_down_sprite kerrek_sprites.png  154 13 188 31 >> kerrek_sprites.inc
	$(HGR_SPRITE) -s -l kerrek_peasant_ground_sprite kerrek_sprites.png  182 41 188 54 >> kerrek_sprites.inc


kerrek_body_sprites.inc:	kerrek_body_sprites.png
	$(HGR_SPRITE) -l kerrek_body1r_sprite kerrek_body_sprites.png 154  28 202  42 > kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body1r_mask   kerrek_body_sprites.png 154  49 202  63 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body0r_sprite kerrek_body_sprites.png  14  28  62  42 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body0r_mask   kerrek_body_sprites.png  14  49  62  63 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body2r_sprite kerrek_body_sprites.png  14  91  62 105 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body2r_mask   kerrek_body_sprites.png  14 112  62 126 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body3r_sprite kerrek_body_sprites.png  14 154  62 168 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body3r_mask   kerrek_body_sprites.png  14 175  62 189 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body1l_sprite kerrek_body_sprites.png 224  28 272  42 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body1l_mask   kerrek_body_sprites.png 224  49 272  63 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body0l_sprite kerrek_body_sprites.png  84  28 132  42 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body0l_mask   kerrek_body_sprites.png  84  49 132  63 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body2l_sprite kerrek_body_sprites.png  84  91 132 105 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body2l_mask   kerrek_body_sprites.png  84 112 132 126 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body3l_sprite kerrek_body_sprites.png  84 154 132 168 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_body3l_mask   kerrek_body_sprites.png  84 175 132 189 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies0_sprite kerrek_body_sprites.png 210  70 230  81 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies0_mask   kerrek_body_sprites.png 210  84 230  95 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies1_sprite kerrek_body_sprites.png 210  99 230 110 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies1_mask   kerrek_body_sprites.png 210 113 230 124 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies2_sprite kerrek_body_sprites.png 210 130 230 140 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies2_mask   kerrek_body_sprites.png 210 143 230 153 >> kerrek_body_sprites.inc

kerrek_belt.inc:	get_belt_full.png
	$(HGR_SPRITE) -s -l belt_base_sprite get_belt_full.png 217 31 244 49 > kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt0_sprite get_belt_full.png   7  63  34  87 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l betl1_sprite get_belt_full.png  49  63  76  83 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt2_sprite get_belt_full.png  91  63 118  79 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt3_sprite get_belt_full.png 133  62 160  74 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt4_sprite get_belt_full.png 182  60 199  73 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt5_sprite get_belt_full.png  14 103  27 122 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt6_sprite get_belt_full.png  56 100  69 122 >> kerrek_belt.inc
	$(HGR_SPRITE) -s -l belt7_sprite get_belt_full.png  91  97 118 122 >> kerrek_belt.inc

kerrek_hit_sprites.inc:	kerrek_hit_sprites_left.png kerrek_hit_sprites_right.png kerrek_body_sprites.png
	$(HGR_SPRITE) -l kerrek_hit_left0_sprite kerrek_hit_sprites_left.png  14  60  41 108 > kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left0_mask   kerrek_hit_sprites_left.png  14 113  41 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left1_sprite kerrek_hit_sprites_left.png  56  60 104 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left1_mask   kerrek_hit_sprites_left.png  56 113 104 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left2_sprite kerrek_hit_sprites_left.png 112  64 146 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left2_mask   kerrek_hit_sprites_left.png 112 116 146 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left3_sprite kerrek_hit_sprites_left.png 154  63 195 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left3_mask   kerrek_hit_sprites_left.png 154 116 195 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left4_sprite kerrek_hit_sprites_left.png 210  35 258  58 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left4_mask   kerrek_hit_sprites_left.png 210  63 258  86 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left5_sprite kerrek_body_sprites.png  84  28 132  42 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left5_mask   kerrek_body_sprites.png  84  49 132  63 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left6_sprite kerrek_hit_sprites_left.png 210 136 251 159 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_left6_mask   kerrek_hit_sprites_left.png 210 162 251 185 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right0_sprite kerrek_hit_sprites_right.png  14  60  41 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right0_mask   kerrek_hit_sprites_right.png  14 113  41 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right1_sprite kerrek_hit_sprites_right.png  56  60 104 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right1_mask   kerrek_hit_sprites_right.png  56 113 104 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right2_sprite kerrek_hit_sprites_right.png 112  64 146 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right2_mask   kerrek_hit_sprites_right.png 112 116 146 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right3_sprite kerrek_hit_sprites_right.png 154  63 195 108 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right3_mask   kerrek_hit_sprites_right.png 154 116 195 161 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right4_sprite kerrek_hit_sprites_right.png 210  35 258  58 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right4_mask   kerrek_hit_sprites_right.png 210  63 258  86 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right5_sprite kerrek_body_sprites.png  14  28  62  42 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right5_mask   kerrek_body_sprites.png  14  49  62  63 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right6_sprite kerrek_hit_sprites_right.png 210 136 251 159 >> kerrek_hit_sprites.inc
	$(HGR_SPRITE) -l kerrek_hit_right6_mask   kerrek_hit_sprites_right.png 210 162 251 185 >> kerrek_hit_sprites.inc









clean:
	rm -f *~ kerrek_sprites.inc kerrek_body_sprites.inc kerrek_belt.inc kerrek_hit_sprites.inc
