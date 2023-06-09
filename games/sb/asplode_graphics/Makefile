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
	$(HGR_SPRITE) -s -l big_head_sprite sb_sprites.png   84 36 132 92 > sb_sprites.inc
	$(HGR_SPRITE) -s -l player_sprite sb_sprites.png 98 138 181 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_left_sprite sb_sprites.png 0 138 83 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_center_sprite sb_sprites.png 196 83 279 137 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l shield_right_sprite sb_sprites.png 196 138 279 192 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet0_sprite sb_sprites.png 168 1 181 7 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet1_sprite sb_sprites.png 168 8 181 14 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet2_sprite sb_sprites.png 168 15 181 21 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet3_sprite sb_sprites.png 168 22 181 28 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet4_sprite sb_sprites.png 168 29 181 35 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet5_sprite sb_sprites.png 168 36 181 42 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet6_sprite sb_sprites.png 168 43 181 49 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet7_sprite sb_sprites.png 168 50 181 56 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet8_sprite sb_sprites.png 168 57 181 63 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet9_sprite sb_sprites.png 168 64 181 70 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet10_sprite sb_sprites.png 168 71 181 77 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet11_sprite sb_sprites.png 168 78 181 84 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet12_sprite sb_sprites.png 168 85 181 91 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet13_sprite sb_sprites.png 168 92 181 98 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet14_sprite sb_sprites.png 168 99 181 105 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l bullet15_sprite sb_sprites.png 168 106 181 112 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l your_sprite sb_sprites.png 0 0 41 19 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l head_sprite sb_sprites.png 56 0 90 19 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l a_sprite sb_sprites.png 98 0 104 19 >> sb_sprites.inc
	$(HGR_SPRITE) -s -l splode_sprite sb_sprites.png 112 0 166 19 >> sb_sprites.inc

####

clean:
	rm -f *~ *.o *.lst sb_sprites.inc

