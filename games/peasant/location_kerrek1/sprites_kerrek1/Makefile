HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	kerrek_sprites.inc kerrek_body_sprites.inc

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
	$(HGR_SPRITE) -l kerrek_flies0_sptite kerrek_body_sprites.png 210  70 230  81 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies0_mask   kerrek_body_sprites.png 210  84 230  95 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies1_sptite kerrek_body_sprites.png 210  99 230 110 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies1_mask   kerrek_body_sprites.png 210 113 230 124 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies2_sptite kerrek_body_sprites.png 210 130 230 140 >> kerrek_body_sprites.inc
	$(HGR_SPRITE) -l kerrek_flies2_mask   kerrek_body_sprites.png 210 203 230 223 >> kerrek_body_sprites.inc






clean:
	rm -f *~ kerrek_sprites.inc kerrek_body_sprites.inc
