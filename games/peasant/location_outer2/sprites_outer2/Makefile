
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper2_sprites.inc guitar_sprites.inc

keeper2_sprites.inc:	keeper2_sprites.png
	$(HGR_SPRITE) -l keeper_l0 keeper2_sprites.png  14 128  34 156 > keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l1 keeper2_sprites.png  42 128  62 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l2 keeper2_sprites.png  70 128  90 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l3 keeper2_sprites.png  98 128 118 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l4 keeper2_sprites.png 126 128 146 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l5 keeper2_sprites.png 154 128 174 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l6 keeper2_sprites.png 182 128 202 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l7 keeper2_sprites.png 210 128 230 156 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l0_mask keeper2_sprites.png  14 159 34 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l1_mask keeper2_sprites.png  42 159 62 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l2_mask keeper2_sprites.png  70 159 90 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l3_mask keeper2_sprites.png  98 159 118 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l4_mask keeper2_sprites.png 126 159 146 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l5_mask keeper2_sprites.png 154 159 174 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l6_mask keeper2_sprites.png 182 159 202 187 >> keeper2_sprites.inc
	$(HGR_SPRITE) -l keeper_l7_mask keeper2_sprites.png 210 159 230 187 >> keeper2_sprites.inc

guitar_sprites.inc:	guitar_sprites.png
	$(HGR_SPRITE) -l guitar0 guitar_sprites.png  14 128  27 158 > guitar_sprites.inc
	$(HGR_SPRITE) -l guitar1 guitar_sprites.png  56 128  68 158 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar2 guitar_sprites.png  98 128 118 158 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar3 guitar_sprites.png 140 128 167 158 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar4 guitar_sprites.png 140  32 167 62 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar5 guitar_sprites.png  14  32  41 62 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar6 guitar_sprites.png  56  32  83 62 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar7 guitar_sprites.png  98  32 125 62 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar0_mask guitar_sprites.png  14 159  27 189 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar1_mask guitar_sprites.png  56 159  68 189 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar2_mask guitar_sprites.png  98 159 118 189 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar3_mask guitar_sprites.png 140 159 167 189 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar4_mask guitar_sprites.png 140  63 167 93 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar5_mask guitar_sprites.png  14  63  41 93 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar6_mask guitar_sprites.png  56  63  83 93 >> guitar_sprites.inc
	$(HGR_SPRITE) -l guitar7_mask guitar_sprites.png  98  63 125 93 >> guitar_sprites.inc

clean:
	rm -f *~ \
		keeper2_sprites.inc guitar_sprites.inc
