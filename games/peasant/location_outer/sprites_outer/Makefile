
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	keeper1_sprites.inc ron_sprites.inc


keeper1_sprites.inc:	keeper1_sprites.png
	$(HGR_SPRITE) -l keeper_r0 keeper1_sprites.png  14 128  27 156 > keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r1 keeper1_sprites.png  42 128  55 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r2 keeper1_sprites.png  70 128  90 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r3 keeper1_sprites.png  98 128 118 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r4 keeper1_sprites.png 126 128 146 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r5 keeper1_sprites.png 154 128 174 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r6 keeper1_sprites.png 182 128 202 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r7 keeper1_sprites.png 210 128 230 156 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r0_mask keeper1_sprites.png  14 159 27 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r1_mask keeper1_sprites.png  42 159 55 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r2_mask keeper1_sprites.png  70 159 90 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r3_mask keeper1_sprites.png  98 159 118 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r4_mask keeper1_sprites.png 126 159 146 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r5_mask keeper1_sprites.png 154 159 174 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r6_mask keeper1_sprites.png 182 159 202 187 >> keeper1_sprites.inc
	$(HGR_SPRITE) -l keeper_r7_mask keeper1_sprites.png 210 159 230 187 >> keeper1_sprites.inc

ron_sprites.inc:	keeper1_sprites.png
	$(HGR_SPRITE) -l ron0 keeper1_sprites.png  14 32  27 61 > ron_sprites.inc
	$(HGR_SPRITE) -l ron1 keeper1_sprites.png  42 32  55 62 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron2 keeper1_sprites.png  70 32  83 62 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron3 keeper1_sprites.png  98 32 111 62 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron4 keeper1_sprites.png 126 32 139 62 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron0_mask keeper1_sprites.png  14 63  27 93 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron1_mask keeper1_sprites.png  42 63  55 93 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron2_mask keeper1_sprites.png  70 63  83 93 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron3_mask keeper1_sprites.png  98 63 111 93 >> ron_sprites.inc
	$(HGR_SPRITE) -l ron4_mask keeper1_sprites.png 126 63 139 93 >> ron_sprites.inc

clean:
	rm -f *~ \
		keeper1_sprites.inc ron_sprites.inc

