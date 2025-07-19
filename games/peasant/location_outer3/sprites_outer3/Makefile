
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper3_sprites.inc skeleton_sprites.inc curtain_sprites.inc \
	sword_sprites.inc

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
	$(HGR_SPRITE) -l skeleton0 skeleton_sprites.png  14 32  27 62 > skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton1 skeleton_sprites.png  42 32  55 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton2 skeleton_sprites.png  70 32  83 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton3 skeleton_sprites.png  98 32 111 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton4 skeleton_sprites.png 126 32 139 62 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton0_mask skeleton_sprites.png  14 63  27 93 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton1_mask skeleton_sprites.png  42 63  55 93 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton2_mask skeleton_sprites.png  70 63  83 93 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton3_mask skeleton_sprites.png  98 63 111 93 >> skeleton_sprites.inc
	$(HGR_SPRITE) -l skeleton4_mask skeleton_sprites.png 126 63 139 93 >> skeleton_sprites.inc

curtain_sprites.inc:	curtain_sprites.png
	$(HGR_SPRITE) -s -l curtain0 curtain_sprites.png 189 112 216 160 > curtain_sprites.inc
	$(HGR_SPRITE) -s -l curtain1 curtain_sprites.png 133 112 160 160 >> curtain_sprites.inc
	$(HGR_SPRITE) -s -l curtain2 curtain_sprites.png  77 112 104 160 >> curtain_sprites.inc

sword_sprites.inc:	get_sword.png
	$(HGR_SPRITE) -l sword_base_sprite get_sword.png  0 34  20 64 > sword_sprites.inc
	$(HGR_SPRITE) -l sword0_sprite get_sword.png  28 34  41 64 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword1_sprite get_sword.png  56 40  69 54 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword2_sprite get_sword.png  84 40  97 54 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword3_sprite get_sword.png 112 34 125 52 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword4_sprite get_sword.png 140 40 153 61 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword5_sprite get_sword.png 168 46 181 67 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword6_sprite get_sword.png 196 49 209 73 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword7_sprite get_sword.png 224 51 244 77 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword8_sprite get_sword.png 252 53 272 81 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword_base_mask get_sword.png  0 67  20 97 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword0_mask get_sword.png  28 73  41 97 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword1_mask get_sword.png  56 73  69 87 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword2_mask get_sword.png  84 73  97 87 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword3_mask get_sword.png 112 67 125 85 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword4_mask get_sword.png 140 79 153 100 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword5_mask get_sword.png 168 91 181 112 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword6_mask get_sword.png 196 97 209 121 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword7_mask get_sword.png 224 101 244 127 >> sword_sprites.inc
	$(HGR_SPRITE) -l sword8_mask get_sword.png 252 105 272 133 >> sword_sprites.inc



clean:
	rm -f *~ \
		keeper3_sprites.inc skeleton_sprites.inc \
		sword_sprites.inc curtain_sprites.inc
