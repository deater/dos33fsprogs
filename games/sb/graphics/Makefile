include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites

all:	strongbad_sample.hgr.zx02 \
	a2_duckpond_title.gr.zx02 a2_duckpond.gr.zx02 \
	num_sprites.inc

####

num_sprites.inc:	lores_font.png
	$(PNG2SPRITES) lores_font.png zero_sprite   0 0 3 6 >  num_sprites.inc
	$(PNG2SPRITES) lores_font.png one_sprite    4 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png two_sprite    8 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png three_sprite 12 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png four_sprite  16 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png five_sprite  20 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png six_sprite   24 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png seven_sprite 28 0 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png eight_sprite  0 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png nine_sprite   4 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png colon_sprite  8 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png d_sprite     12 6 3 6 >> num_sprites.inc
	$(PNG2SPRITES) lores_font.png space_sprite 16 6 3 6 >> num_sprites.inc



####

strongbad_sample.hgr.zx02:	strongbad_sample.hgr
	$(ZX02) strongbad_sample.hgr strongbad_sample.hgr.zx02

strongbad_sample.hgr:	strongbad_sample.png
	$(PNG_TO_HGR) strongbad_sample.png > strongbad_sample.hgr

####

a2_duckpond_title.gr.zx02:	a2_duckpond_title.gr
	$(ZX02) a2_duckpond_title.gr a2_duckpond_title.gr.zx02

a2_duckpond_title.gr:	a2_duckpond_title.png
	$(PNG2GR) a2_duckpond_title.png a2_duckpond_title.gr

####

a2_duckpond.gr.zx02:	a2_duckpond.gr
	$(ZX02) a2_duckpond.gr a2_duckpond.gr.zx02

a2_duckpond.gr:	a2_duckpond.png
	$(PNG2GR) a2_duckpond.png a2_duckpond.gr



####

clean:
	rm -f *~ *.o *.lst

