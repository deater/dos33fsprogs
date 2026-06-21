HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	inventory_sprites.inc inventory_sprites.zx02

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


inventory_sprites_full.inc:	inventory_new.png
	$(HGR_SPRITE) -l arrow_sprite inventory_new.png  0  1 41 50 > inventory_sprites_full.inc
	$(HGR_SPRITE) -l baby_sprite inventory_new.png  42  1 83 50 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l kerrek_belt_sprite inventory_new.png 84 1 125 50 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l chicken_feed_sprite inventory_new.png 126 1 167 50 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l bow_sprite inventory_new.png 168 1 209 50 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l mask_sprite inventory_new.png 210 1 251 50 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l pebbles_sprite inventory_new.png 0 68 41 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l pills_sprite inventory_new.png 42 68 83 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l riches_sprite inventory_new.png 84 68 125 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l robe_sprite inventory_new.png 126 68 167 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l soda_sprite inventory_new.png 168 68 209 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l sub_sprite inventory_new.png 210 68 251 117 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l trinket_sprite inventory_new.png 0 140 41 189 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l troghelm_sprite inventory_new.png 42 140 83 189 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l trogshield_sprite inventory_new.png 84 140 125 189 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l trogsword_sprite inventory_new.png 126 140 167 189 >> inventory_sprites_full.inc
#	$(HGR_SPRITE) -l map_sprite inventory_new.png 210 140 251 189 >> inventory_sprites_full.inc
	$(HGR_SPRITE) -l tshirt_sprite inventory_new.png 168 140 209 189 >> inventory_sprites_full.inc



inventory_sprites_new.inc:	inventory_new.png
	$(HGR_SPRITE) -l arrow_sprite inventory_new.png  7  1 41 49 > inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l baby_sprite inventory_new.png  49  1 83 49 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l kerrek_belt_sprite inventory_new.png 91 1 125 49 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l chicken_feed_sprite inventory_new.png 133 1 167 49 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l bow_sprite inventory_new.png 175 1 209 49 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l mask_sprite inventory_new.png 217 1 251 49 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l pebbles_sprite inventory_new.png 7 68 41 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l pills_sprite inventory_new.png 49 68 83 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l riches_sprite inventory_new.png 91 68 125 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l robe_sprite inventory_new.png 133 68 167 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l soda_sprite inventory_new.png 175 68 209 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l sub_sprite inventory_new.png 217 68 251 116 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l trinket_sprite inventory_new.png 7 140 41 188 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l troghelm_sprite inventory_new.png 49 140 83 188 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l trogshield_sprite inventory_new.png 91 140 125 188 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l trogsword_sprite inventory_new.png 133 140 167 188 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
#	$(HGR_SPRITE) -l map_sprite inventory_new.png 210 147 251 188 >> inventory_sprites_new.inc
#	echo ".align 256" >> inventory_sprites_new.inc
	$(HGR_SPRITE) -l tshirt_sprite inventory_new.png 175 140 209 188 >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc
	echo "empty_sprite: .byte 0" >> inventory_sprites_new.inc
	echo ".align 256" >> inventory_sprites_new.inc





####

inventory_sprites.zx02:	inventory_sprites
	$(ZX02) -f inventory_sprites inventory_sprites.zx02

inventory_sprites:	inventory_sprites.o
	ld65 -o inventory_sprites inventory_sprites.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

inventory_sprites.o:	inventory_sprites.s \
	inventory_sprites_new.inc
	ca65 -o inventory_sprites.o inventory_sprites.s -l inventory_sprites.lst



clean:
	rm -f *~ inventory_sprites.inc inventory_sprites_new.inc
