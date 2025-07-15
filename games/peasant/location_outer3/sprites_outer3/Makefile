
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper3_sprites.inc skeleton_sprites.inc

keeper3_sprites.inc:	keeper3_sprites.png
	$(HGR_SPRITE) -l keeper_l0 keeper3_sprites.png  14 128  34 156 > keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l1 keeper3_sprites.png  42 128  62 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l2 keeper3_sprites.png  70 128  90 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l3 keeper3_sprites.png  98 128 118 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l4 keeper3_sprites.png 126 128 146 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l5 keeper3_sprites.png 154 128 174 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l6 keeper3_sprites.png 182 128 202 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l7 keeper3_sprites.png 210 128 230 156 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l0_mask keeper3_sprites.png  14 159 34 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l1_mask keeper3_sprites.png  42 159 62 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l2_mask keeper3_sprites.png  70 159 90 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l3_mask keeper3_sprites.png  98 159 118 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l4_mask keeper3_sprites.png 126 159 146 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l5_mask keeper3_sprites.png 154 159 174 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l6_mask keeper3_sprites.png 182 159 202 187 >> keeper3_sprites.inc
	$(HGR_SPRITE) -l keeper_l7_mask keeper3_sprites.png 210 159 230 187 >> keeper3_sprites.inc

skeleton_sprites.inc:	skeleton_sprites.png
	$(HGR_SPRITE) -l guitar0 skeleton_sprites.png  14 128  27 158 > skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar1 skeleton_sprites.png  56 128  68 158 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar2 skeleton_sprites.png  98 128 118 158 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar3 skeleton_sprites.png 140 128 167 158 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar4 skeleton_sprites.png 140  32 167 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar5 skeleton_sprites.png  14  32  41 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar6 skeleton_sprites.png  56  32  83 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar7 skeleton_sprites.png  98  32 125 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar0_mask skeleton_sprites.png  14 159  27 189 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar1_mask skeleton_sprites.png  56 159  68 189 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar2_mask skeleton_sprites.png  98 159 118 189 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar3_mask skeleton_sprites.png 140 159 167 189 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar4_mask skeleton_sprites.png 140  63 167 92 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar5_mask skeleton_sprites.png  14  63  41 92 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar6_mask skeleton_sprites.png  56  63  83 92 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l guitar7_mask skeleton_sprites.png  98  63 125 92 >> skeleton_sprites.inc

clean:
	rm -f *~ \
		keeper3_sprites.inc skeleton_sprites.inc
