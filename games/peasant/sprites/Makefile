HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	inventory_sprites.inc

inventory_sprites.inc:	inventory.png
	$(HGR_SPRITE) -l arrow_sprite inventory.png 14 3 27 19 > inventory_sprites.inc
	$(HGR_SPRITE) -l baby_sprite inventory.png 14 20 27 36 >> inventory_sprites.inc
	$(HGR_SPRITE) -l kerrek_belt_sprite inventory.png 14 37 27 53 >> inventory_sprites.inc
	$(HGR_SPRITE) -l chicken_feed_sprite inventory.png 14 54 27 70 >> inventory_sprites.inc
	$(HGR_SPRITE) -l bow_sprite inventory.png 14 71 27 87 >> inventory_sprites.inc
	$(HGR_SPRITE) -l mask_sprite inventory.png 14 88 27 104 >> inventory_sprites.inc
	$(HGR_SPRITE) -l pebbles_sprite inventory.png 14 105 27 121 >> inventory_sprites.inc
	$(HGR_SPRITE) -l pills_sprite inventory.png 14 122 27 138 >> inventory_sprites.inc
	$(HGR_SPRITE) -l riches_sprite inventory.png 14 139 27 155 >> inventory_sprites.inc
	$(HGR_SPRITE) -l robe_sprite inventory.png 42 3 55 19 >> inventory_sprites.inc
	$(HGR_SPRITE) -l soda_sprite inventory.png 42 20 55 36 >> inventory_sprites.inc
	$(HGR_SPRITE) -l sub_sprite inventory.png 42 37 55 53 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trinket_sprite inventory.png 42 54 55 70 >> inventory_sprites.inc
	$(HGR_SPRITE) -l troghelm_sprite inventory.png 42 71 55 87 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trogshield_sprite inventory.png 42 88 55 104 >> inventory_sprites.inc
	$(HGR_SPRITE) -l trogsword_sprite inventory.png 42 105 55 121 >> inventory_sprites.inc
#	$(HGR_SPRITE) -l no_sprite inventory.png 42 122 55 138 >> inventory_sprites.inc
	$(HGR_SPRITE) -l tshirt_sprite inventory.png 42 139 55 155 >> inventory_sprites.inc







clean:
	rm -f *~ inventory_sprites.inc
