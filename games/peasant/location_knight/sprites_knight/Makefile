HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../../linker_scripts

all:	knight_sprites.inc

####

knight_sprites.inc:     knight_sprites.png
	$(HGR_SPRITE) -l ks0_sprite knight_sprites.png  14  14  34  47 > knight_sprites.inc
	$(HGR_SPRITE) -l ks0_mask   knight_sprites.png  14  50  34  83 >> knight_sprites.inc
	$(HGR_SPRITE) -l kw0_sprite knight_sprites.png  42  14  62  47 >> knight_sprites.inc
	$(HGR_SPRITE) -l kw0_mask   knight_sprites.png  42  50  62  83 >> knight_sprites.inc
	$(HGR_SPRITE) -l kw1_sprite knight_sprites.png  70  14  90  47 >> knight_sprites.inc
	$(HGR_SPRITE) -l kw1_mask   knight_sprites.png  70  50  90  83 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw0_sprite knight_sprites.png  14  86  34 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw0_mask   knight_sprites.png  14 122  34 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw1_sprite knight_sprites.png  42  86  62 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw1_mask   knight_sprites.png  42 122  62 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw2_sprite knight_sprites.png  70  86  90 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw2_mask   knight_sprites.png  70 122  90 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw3_sprite knight_sprites.png  98  86 118 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw3_mask   knight_sprites.png  98 122 118 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw4_sprite knight_sprites.png 126  86 146 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw4_mask   knight_sprites.png 126 122 146 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw5_sprite knight_sprites.png 154  86 174 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw5_mask   knight_sprites.png 154 122 174 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw6_sprite knight_sprites.png 182  86 202 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw6_mask   knight_sprites.png 182 122 202 155 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw7_sprite knight_sprites.png 210  86 230 119 >> knight_sprites.inc
	$(HGR_SPRITE) -l yw7_mask   knight_sprites.png 210 122 230 155 >> knight_sprites.inc

clean:	
	rm -f *~ *.zx02 knight_sprites.inc

distclean:
	make clean
