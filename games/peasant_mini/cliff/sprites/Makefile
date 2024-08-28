HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	enemy_sprites.inc

enemy_sprites.inc:     enemy_sprites.png
	$(HGR_SPRITE) -l bird0_sprite enemy_sprites.png 210 50 230 66 > enemy_sprites.inc
	$(HGR_SPRITE) -l bird0_mask   enemy_sprites.png 238 50 258 66 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bird1_sprite enemy_sprites.png 210 74 230 88 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bird1_mask   enemy_sprites.png 238 74 258 88 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock0_sprite enemy_sprites.png 14  7 34 30 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock0_mask   enemy_sprites.png 42  7 62 30 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock1_sprite enemy_sprites.png 14 35 34 57 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock1_mask   enemy_sprites.png 42 35 62 57 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock2_sprite enemy_sprites.png 14 63 34 84 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock2_mask   enemy_sprites.png 42 63 62 84 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock3_sprite enemy_sprites.png 14 91 34 113 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock3_mask   enemy_sprites.png 42 91 62 113 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash0_sprite enemy_sprites.png 14 119 34 137 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash0_mask   enemy_sprites.png 42 119 62 137 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash1_sprite enemy_sprites.png 14 147 41 168 >> enemy_sprites.inc
	$(HGR_SPRITE) -l bigrock_crash1_mask   enemy_sprites.png 56 147 83 168 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock0_sprite enemy_sprites.png  98  7 111 22 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock0_mask   enemy_sprites.png 126  7 139 22 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock1_sprite enemy_sprites.png  98 35 111 49 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock1_mask   enemy_sprites.png 126 35 139 49 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock2_sprite enemy_sprites.png  98 63 111 78 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock2_mask   enemy_sprites.png 126 63 139 78 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock3_sprite enemy_sprites.png  98 91 111 105 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock3_mask   enemy_sprites.png 126 91 139 105 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash0_sprite enemy_sprites.png 98 119 111 134 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash0_mask   enemy_sprites.png 126 119 139 134 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash1_sprite enemy_sprites.png 126 147 153 166 >> enemy_sprites.inc
	$(HGR_SPRITE) -l smallrock_crash1_mask   enemy_sprites.png 168 147 195 165 >> enemy_sprites.inc




clean:	
	rm -f *~ enemy_sprites.inc

