HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	lightning_sprites.inc ron_sprites.inc

lightning_sprites.inc:	lightning.png
	$(HGR_SPRITE) -s -l small_lightning1 lightning.png 14 3 27 14 > lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning2 lightning.png 42 3 69 21 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning3 lightning.png 84 3 111 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning0 lightning.png 126 3 153 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning1 lightning.png 14 51 41 91 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning2 lightning.png 56 51 97 103 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning3 lightning.png 112 51 167 118 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning0 lightning.png 182 51 237 118 >> lightning_sprites.inc

ron_sprites.inc:	heights_sprites.png
	$(HGR_SPRITE) -s -l ron0 heights_sprites.png  14 32  27 61 > ron_sprites.inc
	$(HGR_SPRITE) -s -l ron1 heights_sprites.png  42 32  55 62 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron2 heights_sprites.png  70 32  83 62 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron3 heights_sprites.png  98 32 111 62 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron4 heights_sprites.png 126 32 139 62 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron0_mask heights_sprites.png  14 63  27 93 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron1_mask heights_sprites.png  42 63  55 93 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron2_mask heights_sprites.png  70 63  83 93 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron3_mask heights_sprites.png  98 63 111 93 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l ron4_mask heights_sprites.png 126 63 139 93 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper0 heights_sprites.png  14 128  27 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper1 heights_sprites.png  42 128  55 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper2 heights_sprites.png  70 128  90 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper3 heights_sprites.png  98 128 118 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper4 heights_sprites.png 126 128 146 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper5 heights_sprites.png 154 128 174 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper6 heights_sprites.png 181 128 202 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper7 heights_sprites.png 210 128 230 156 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper0_mask heights_sprites.png  14 159 27 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper1_mask heights_sprites.png  42 159 55 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper2_mask heights_sprites.png  70 159 90 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper3_mask heights_sprites.png  98 159 118 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper4_mask heights_sprites.png 126 159 146 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper5_mask heights_sprites.png 154 159 174 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper6_mask heights_sprites.png 181 159 202 187 >> ron_sprites.inc
	$(HGR_SPRITE) -s -l keeper7_mask heights_sprites.png 210 159 230 187 >> ron_sprites.inc






clean:
	rm -f *~ lightning_sprites.inc ron_sprites.inc
