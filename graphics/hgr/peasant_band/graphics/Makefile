
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper1_sprites.inc \
	keeper2_sprites.inc guitar_sprites.inc

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

guitar_sprites.inc:	guitar_sprites.png
	$(HGR_SPRITE) -s -l guitar0 guitar_sprites.png  14  32  41 62 > guitar_sprites.inc
	$(HGR_SPRITE) -s -l guitar1 guitar_sprites.png  56  32  83 62 >> guitar_sprites.inc
	$(HGR_SPRITE) -s -l guitar2 guitar_sprites.png  98  32 125 62 >> guitar_sprites.inc
#	$(HGR_SPRITE) -l guitar0_mask guitar_sprites.png  14  63  41 92 >> guitar_sprites.inc
#	$(HGR_SPRITE) -l guitar1_mask guitar_sprites.png  56  63  83 92 >> guitar_sprites.inc
#	$(HGR_SPRITE) -l guitar2_mask guitar_sprites.png  98  63 125 92 >> guitar_sprites.inc


clean:
	rm -f *~ \
		keeper1_sprites.inc \
		keeper2_sprites.inc guitar_sprites.inc
