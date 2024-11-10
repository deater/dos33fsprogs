include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	desire.hgr.zx02 logo_frame01.hgr.zx02 logo_frame46.hgr.zx02 \
	d_sprites.inc


####

d_sprites.inc:	logo_frame11.png logo_frame12.png logo_frame13.png \
		logo_frame14.png logo_frame15.png logo_frame16.png \
		logo_frame17.png logo_frame18.png logo_frame19.png \
		logo_frame20.png logo_frame21.png logo_frame22.png \
		logo_frame23.png
	$(HGR_SPRITE) -s -l d11_sprite logo_frame11.png  70 55  125 109 > d_sprites.inc
	$(HGR_SPRITE) -s -l d12_sprite logo_frame12.png  70 55  125 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d13_sprite logo_frame13.png  70 55  125 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d14_sprite logo_frame14.png  56 55  125 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d15_sprite logo_frame15.png  56 56  125 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d16_sprite logo_frame16.png  42 56  125 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d17_sprite logo_frame17.png  42 56  111 107 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d18_sprite logo_frame18.png  42 56  111 107 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d19_sprite logo_frame19.png  28 56   97 108 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d20_sprite logo_frame20.png  28 56   97 108 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d21_sprite logo_frame21.png  14 55   83 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d22_sprite logo_frame22.png  14 55   83 109 >> d_sprites.inc
	$(HGR_SPRITE) -s -l d23_sprite logo_frame23.png  14 54   97 109 >> d_sprites.inc


####

logo_frame01.hgr:	logo_frame01.png
	$(PNG_TO_HGR) logo_frame01.png > logo_frame01.hgr

logo_frame01.hgr.zx02:	logo_frame01.hgr
	$(ZX02) -f logo_frame01.hgr logo_frame01.hgr.zx02


####

logo_frame46.hgr:	logo_frame46.png
	$(PNG_TO_HGR) logo_frame46.png > logo_frame46.hgr

logo_frame46.hgr.zx02:	logo_frame46.hgr
	$(ZX02) -f logo_frame46.hgr logo_frame46.hgr.zx02

####

desire.hgr:	desire-cyan-steffest.png
	$(PNG_TO_HGR) desire-cyan-steffest.png > desire.hgr

desire.hgr.zx02:	desire.hgr
	$(ZX02) -f desire.hgr desire.hgr.zx02

####

clean:
	rm -f *~ *.zx02 *.hgr *.inc
