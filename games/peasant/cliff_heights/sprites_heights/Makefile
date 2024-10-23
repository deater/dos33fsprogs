
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	lightning_sprites.inc

lightning_sprites.inc:	lightning.png
	$(HGR_SPRITE) -s -l small_lightning1 lightning.png 14 3 27 14 > lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning2 lightning.png 42 3 69 21 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning3 lightning.png 84 3 111 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning0 lightning.png 126 3 153 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning1 lightning.png 14 51 41 91 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning2 lightning.png 56 51 97 103 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning3 lightning.png 112 51 167 118 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning0 lightning.png 182 51 237 118 >> lightning_sprites.inc

clean:
	rm -f *~ lightning_sprites.inc \
		keeper1_sprites.inc ron_sprites.inc \
		keeper2_sprites.inc
