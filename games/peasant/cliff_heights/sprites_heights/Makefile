HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	lightning_sprites.inc

lightning_sprites.inc:	lightning.png
	$(HGR_SPRITE) -s -l small_lightning0 lightning.png 14 3 27 15 > lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning1 lightning.png 42 3 62 21 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning2 lightning.png 77 3 104 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l small_lightning3 lightning.png 119 3 146 29 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning0 lightning.png 14 51 34 91 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning1 lightning.png 49 51 83 103 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning2 lightning.png 98 51 146 118 >> lightning_sprites.inc
	$(HGR_SPRITE) -s -l big_lightning3 lightning.png 161 51 209 118 >> lightning_sprites.inc



clean:
	rm -f *~ lightning_sprites.inc
