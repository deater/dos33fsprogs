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

all:	keen1_title.hgr.zx02 level1_bg.gr.zx02 parts.gr.zx02 \
	keen1_story.hgr.zx02 title_sprites.inc

####

title_sprites.inc:	title_sprites.png
	$(HGR_SPRITE) -s -l title_sprite title_sprites.png  0   0 167  95 > title_sprites.inc
	$(HGR_SPRITE) -s -l ball_bg title_sprites.png  0  96 6 104 >> title_sprites.inc
	$(HGR_SPRITE) -s -l ball0 title_sprites.png    0 105 6 113 >> title_sprites.inc
	$(HGR_SPRITE) -s -l ball1 title_sprites.png    0 114 6 122 >> title_sprites.inc
	$(HGR_SPRITE) -s -l ball2 title_sprites.png    0 123 6 131 >> title_sprites.inc

####

keen1_title.hgr.zx02:	keen1_title.hgr
	$(ZX02) keen1_title.hgr keen1_title.hgr.zx02

keen1_title.hgr:	keen1_title.png
	$(PNG_TO_HGR) keen1_title.png > keen1_title.hgr

####

keen1_story.hgr.zx02:	keen1_story.hgr
	$(ZX02) keen1_story.hgr keen1_story.hgr.zx02

keen1_story.hgr:	keen1_story.png
	$(PNG_TO_HGR) keen1_story.png > keen1_story.hgr


####

level1_bg.gr.zx02:	level1_bg.gr
	$(ZX02) level1_bg.gr level1_bg.gr.zx02

level1_bg.gr:	level1_bg.png
	$(PNG2GR) level1_bg.png level1_bg.gr

####

parts.gr.zx02:	parts.gr
	$(ZX02) parts.gr parts.gr.zx02

parts.gr:	parts.png
	$(PNG2GR) parts.png parts.gr


####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr

