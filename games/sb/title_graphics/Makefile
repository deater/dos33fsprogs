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

all:	czmg4ap_title.hgr.zx02 \
	title_sprites.inc \
	videlectrix_top.hgr.zx02 \
	the_cheat_loading.hgr.zx02

####

czmg4ap_title.hgr.zx02:	czmg4ap_title.hgr
	$(ZX02) czmg4ap_title.hgr czmg4ap_title.hgr.zx02

czmg4ap_title.hgr:	czmg4ap_title.png
	$(PNG_TO_HGR) czmg4ap_title.png > czmg4ap_title.hgr

####

title_sprites.inc:	czmg4ap_title_sprites.png
	$(HGR_SPRITE) -s -l empty_sprite czmg4ap_title_sprites.png  105 131 118 138 > title_sprites.inc
	$(HGR_SPRITE) -s -l arrow_sprite czmg4ap_title_sprites.png  105 111 118  118 >> title_sprites.inc
	$(HGR_SPRITE) -s -l purple_sprite czmg4ap_title_sprites.png 175  83 230 102 >> title_sprites.inc


####

videlectrix_top.hgr.zx02:	videlectrix_top.hgr
	$(ZX02) videlectrix_top.hgr videlectrix_top.hgr.zx02

videlectrix_top.hgr:	videlectrix_top.png
	$(PNG_TO_HGR) videlectrix_top.png > videlectrix_top.hgr

####

the_cheat_loading.hgr.zx02:	the_cheat_loading.hgr
	$(ZX02) the_cheat_loading.hgr the_cheat_loading.hgr.zx02

the_cheat_loading.hgr:	the_cheat_loading.png
	$(PNG_TO_HGR) the_cheat_loading.png > the_cheat_loading.hgr


####

clean:
	rm -f *~ *.o *.lst

