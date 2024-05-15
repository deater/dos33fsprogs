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

all:	pointer_sprites.inc

####

pointer_sprites.inc:	pointer_sprites.png
	$(HGR_SPRITE) -l point_sprite pointer_sprites.png 0  0  13 14 > pointer_sprites.inc
	$(HGR_SPRITE) -l point_mask pointer_sprites.png   0 15  13 29 >> pointer_sprites.inc
	$(HGR_SPRITE) -l grab_sprite pointer_sprites.png 28  0  41 14 >> pointer_sprites.inc
	$(HGR_SPRITE) -l grab_mask pointer_sprites.png   28 15  41 29 >> pointer_sprites.inc
	$(HGR_SPRITE) -l right_sprite pointer_sprites.png 0 30  13 44 >> pointer_sprites.inc
	$(HGR_SPRITE) -l right_mask pointer_sprites.png   0 45  13 59 >> pointer_sprites.inc
	$(HGR_SPRITE) -l left_sprite pointer_sprites.png 28 30  41 44 >> pointer_sprites.inc
	$(HGR_SPRITE) -l left_mask pointer_sprites.png   28 45  41 59 >> pointer_sprites.inc
	$(HGR_SPRITE) -l uturn_right_sprite pointer_sprites.png 0  60  13 74 >> pointer_sprites.inc
	$(HGR_SPRITE) -l uturn_right_mask pointer_sprites.png   0 75  13 89 >> pointer_sprites.inc
	$(HGR_SPRITE) -l uturn_left_sprite pointer_sprites.png 28 60  41 74 >> pointer_sprites.inc
	$(HGR_SPRITE) -l uturn_left_mask pointer_sprites.png   28 75  41 89 >> pointer_sprites.inc








####

clean:
	rm -f *~ *.o *.lst *.zx02 *.hgr pointer_sprites.inc

