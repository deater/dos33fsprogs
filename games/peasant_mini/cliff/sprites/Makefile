HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	enemy_sprites.inc

enemy_sprites.inc:     enemy_sprites.png
	$(HGR_SPRITE) -s -l bird0_sprite enemy_sprites.png 210 50 230 66 > enemy_sprites.inc
	$(HGR_SPRITE) -s -l bird0_mask   enemy_sprites.png 238 50 258 66 >> enemy_sprites.inc
	$(HGR_SPRITE) -s -l bird1_sprite enemy_sprites.png 210 74 230 88 >> enemy_sprites.inc
	$(HGR_SPRITE) -s -l bird1_mask   enemy_sprites.png 238 74 258 88 >> enemy_sprites.inc


clean:	
	rm -f *~ enemy_sprites.inc

