HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	kerrek_sprites.inc

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

clean:
	rm -f *~ kerrek_sprites.inc
