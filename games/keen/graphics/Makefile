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

all:	keen1_title.hgr.zx02 level1_bg.gr.zx02

####

#disk_sprites.inc:	a2_fortnight_sprites.png
#	$(HGR_SPRITE) -s -l disk_sprite0 a2_fortnight_sprites.png  14   7 41  34 > disk_sprites.inc

####

keen1_title.hgr.zx02:	keen1_title.hgr
	$(ZX02) keen1_title.hgr keen1_title.hgr.zx02

keen1_title.hgr:	keen1_title.png
	$(PNG_TO_HGR) keen1_title.png > keen1_title.hgr

####

level1_bg.gr.zx02:	level1_bg.gr
	$(ZX02) level1_bg.gr level1_bg.gr.zx02

level1_bg.gr:	level1_bg.png
	$(PNG2GR) level1_bg.png level1_bg.gr


####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr

