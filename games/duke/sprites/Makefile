include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	duke_sprites.inc

####

duke_sprites.inc:	duke_sprites.png
	$(PNG2SPRITES) duke_sprites.png duke_sprite_stand_right    1  2 4 8 >  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_stand_left     6  2 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_walking_right  1 12 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_walking_left   6 12 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_jumping_right  1 22 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_jumping_left   6 22 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_falling_right  1 32 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_falling_left   6 32 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_shooting_right 11 2 4 8 >>  duke_sprites.inc
	$(PNG2SPRITES) duke_sprites.png duke_sprite_shooting_left  16 2 4 8 >>  duke_sprites.inc


####

clean:
	rm -f *~ *.o *.lst duke_sprites.inc

