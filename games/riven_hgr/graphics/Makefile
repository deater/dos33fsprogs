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

all:	riven_title.hgr.zx02 \
	maglev1_n.hgr.zx02 maglev1_s.hgr.zx02 maglev1_e.hgr.zx02 maglev1_w.hgr.zx02 \
	maglev2_n.hgr.zx02 \
	maglev3_n.hgr.zx02

####

#title_sprites.inc:	title_sprites.png
#	$(HGR_SPRITE) -s -l title_sprite title_sprites.png  0   0 167  95 > title_sprites.inc
#	$(HGR_SPRITE) -s -l ball_bg title_sprites.png  0  96 6 104 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball0 title_sprites.png    0 105 6 113 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball1 title_sprites.png    0 114 6 122 >> title_sprites.inc
#	$(HGR_SPRITE) -s -l ball2 title_sprites.png    0 123 6 131 >> title_sprites.inc

####

maglev1_n.hgr.zx02:	maglev1_n.hgr
	$(ZX02) maglev1_n.hgr maglev1_n.hgr.zx02

maglev1_n.hgr:	maglev1_n.png
	$(PNG_TO_HGR) maglev1_n.png > maglev1_n.hgr

####

maglev1_s.hgr.zx02:	maglev1_s.hgr
	$(ZX02) maglev1_s.hgr maglev1_s.hgr.zx02

maglev1_s.hgr:	maglev1_s.png
	$(PNG_TO_HGR) maglev1_s.png > maglev1_s.hgr

####

maglev1_e.hgr.zx02:	maglev1_e.hgr
	$(ZX02) maglev1_e.hgr maglev1_e.hgr.zx02

maglev1_e.hgr:	maglev1_e.png
	$(PNG_TO_HGR) maglev1_e.png > maglev1_e.hgr

####

maglev1_w.hgr.zx02:	maglev1_w.hgr
	$(ZX02) maglev1_w.hgr maglev1_w.hgr.zx02

maglev1_w.hgr:	maglev1_w.png
	$(PNG_TO_HGR) maglev1_w.png > maglev1_w.hgr


####

maglev2_n.hgr.zx02:	maglev2_n.hgr
	$(ZX02) maglev2_n.hgr maglev2_n.hgr.zx02

maglev2_n.hgr:	maglev2_n.png
	$(PNG_TO_HGR) maglev2_n.png > maglev2_n.hgr

####

maglev3_n.hgr.zx02:	maglev3_n.hgr
	$(ZX02) maglev3_n.hgr maglev3_n.hgr.zx02

maglev3_n.hgr:	maglev3_n.png
	$(PNG_TO_HGR) maglev3_n.png > maglev3_n.hgr

####

riven_title.hgr.zx02:	riven_title.hgr
	$(ZX02) riven_title.hgr riven_title.hgr.zx02

riven_title.hgr:	riven_title.png
	$(PNG_TO_HGR) riven_title.png > riven_title.hgr



####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr

