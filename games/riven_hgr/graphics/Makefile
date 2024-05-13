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

all:	maglev1.hgr.zx02

####

#title_sprites.inc:	title_sprites.png
#	$(HGR_SPRITE) -s -l title_sprite title_sprites.png  0   0 167  95 > title_sprites.inc
#	$(HGR_SPRITE) -s -l ball_bg title_sprites.png  0  96 6 104 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball0 title_sprites.png    0 105 6 113 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball1 title_sprites.png    0 114 6 122 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball2 title_sprites.png    0 123 6 131 >> title_sprites.inc

####

maglev1.hgr.zx02:	maglev1.hgr
	$(ZX02) maglev1.hgr maglev1.hgr.zx02

maglev1.hgr:	maglev1.png
	$(PNG_TO_HGR) maglev1.png > maglev1.hgr

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr

