
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper1_sprites.inc \
	keeper2_sprites.inc \
	other_sprites.inc

other_sprites.inc:	other_sprites.png
	$(HGR_SPRITE) -s -l demosplash_sprite other_sprites.png 14 8 34 25 > other_sprites.inc
	$(HGR_SPRITE) -s -l vmw_sprite other_sprites.png 42 8 90 20 >> other_sprites.inc
	$(HGR_SPRITE) -s -l m_sprite other_sprites.png 14 35 27 45 >> other_sprites.inc
	$(HGR_SPRITE) -s -l o_sprite other_sprites.png 14 47 27 57 >> other_sprites.inc
	$(HGR_SPRITE) -s -l n_sprite other_sprites.png 14 59 27 69 >> other_sprites.inc
	$(HGR_SPRITE) -s -l s_sprite other_sprites.png 14 71 27 81 >> other_sprites.inc
	$(HGR_SPRITE) -s -l t_sprite other_sprites.png 14 83 27 93 >> other_sprites.inc
	$(HGR_SPRITE) -s -l e_sprite other_sprites.png 14 95 27 105 >> other_sprites.inc
	$(HGR_SPRITE) -s -l r_sprite other_sprites.png 14 107 27 117 >> other_sprites.inc
	$(HGR_SPRITE) -s -l p_sprite other_sprites.png 42 35 55 45 >> other_sprites.inc
	$(HGR_SPRITE) -s -l l_sprite other_sprites.png 42 47 55 57 >> other_sprites.inc
	$(HGR_SPRITE) -s -l a_sprite other_sprites.png 42 59 55 69 >> other_sprites.inc
	$(HGR_SPRITE) -s -l h_sprite other_sprites.png 42 71 55 81 >> other_sprites.inc
	$(HGR_SPRITE) -s -l peasant other_sprites.png 154 77 167 107 >> other_sprites.inc


keeper1_sprites.inc:	keeper1_sprites.png
	$(HGR_SPRITE) -s -l keeper_r0 keeper1_sprites.png  14 128  27 156 > keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r1 keeper1_sprites.png  42 128  62 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r2 keeper1_sprites.png  70 128  90 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r3 keeper1_sprites.png  98 128 118 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r4 keeper1_sprites.png 126 128 146 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r5 keeper1_sprites.png 154 128 174 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r6 keeper1_sprites.png 182 128 202 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -s -l keeper_r7 keeper1_sprites.png 210 128 230 156 >> keeper1_sprites.inc

keeper2_sprites.inc:	keeper2_sprites.png
	$(HGR_SPRITE) -s -l keeper_l0 keeper2_sprites.png  14 128  34 156 > keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l1 keeper2_sprites.png  42 128  62 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l2 keeper2_sprites.png  70 128  90 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l3 keeper2_sprites.png  98 128 118 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l4 keeper2_sprites.png 126 128 146 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l5 keeper2_sprites.png 154 128 174 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l6 keeper2_sprites.png 182 128 202 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -s -l keeper_l7 keeper2_sprites.png 210 128 230 156 >> keeper2_sprites.inc


clean:
	rm -f *~ *.inc


