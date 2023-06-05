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

all:	sb_zone.hgr.zx02 sb_title.hgr.zx02 sb_sprites.inc

####

sb_zone.hgr.zx02:	sb_zone.hgr
	$(ZX02) sb_zone.hgr sb_zone.hgr.zx02

sb_zone.hgr:	sb_zone.png
	$(PNG_TO_HGR) sb_zone.png > sb_zone.hgr

####

sb_title.hgr.zx02:	sb_title.hgr
	$(ZX02) sb_title.hgr sb_title.hgr.zx02

sb_title.hgr:	sb_title.png
	$(PNG_TO_HGR) sb_title.png > sb_title.hgr


####

sb_sprites.inc:	sb_sprites.png
	$(HGR_SPRITE) -s -l head_sprite sb_sprites.png   84 36 132 92 > sb_sprites.inc
	$(HGR_SPRITE) -s -l player_sprite sb_sprites.png 98 138 181 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_left_sprite sb_sprites.png 0 138 83 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_center_sprite sb_sprites.png 196 83 279 137 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_right_sprite sb_sprites.png 196 138 279 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet0_sprite sb_sprites.png 210 9 223 14 >> sb_sprites.inc







####

clean:
	rm -f *~ *.o *.lst

