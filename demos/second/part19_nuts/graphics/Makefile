include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	nuts4.hgr.zx02 nuts_pg.hgr.zx02 nuts_blue.hgr.zx02 \
	fc_grey.hgr.zx02 fc_iipix.hgr.zx02 ship_sprites.inc

####

ship_sprites.inc: ship_sprites.png
	$(HGR_SPRITE) -s -l small_ship_sprite ship_sprites.png   14 7  27 13 > ship_sprites.inc
	$(HGR_SPRITE) -s -l medium_ship_sprite ship_sprites.png  14 21 41 36 >> ship_sprites.inc
	$(HGR_SPRITE) -s -l large_ship_sprite ship_sprites.png   14 49 69 81 >> ship_sprites.inc




####

nuts4.hgr:	nuts4.png
	$(PNG_TO_HGR) nuts4.png > nuts4.hgr

nuts4.hgr.zx02:	nuts4.hgr
	$(ZX02) nuts4.hgr nuts4.hgr.zx02

####

nuts_blue.hgr:	nuts_blue.png
	$(PNG_TO_HGR) nuts_blue.png > nuts_blue.hgr

nuts_blue.hgr.zx02:	nuts_blue.hgr
	$(ZX02) nuts_blue.hgr nuts_blue.hgr.zx02

####

nuts_pg.hgr:	nuts_pg.png
	$(PNG_TO_HGR) nuts_pg.png > nuts_pg.hgr

nuts_pg.hgr.zx02:	nuts_pg.hgr
	$(ZX02) nuts_pg.hgr nuts_pg.hgr.zx02


####

fc_grey.hgr:	fc_grey.png
	$(PNG_TO_HGR) fc_grey.png > fc_grey.hgr

fc_grey.hgr.zx02:	fc_grey.hgr
	$(ZX02) fc_grey.hgr fc_grey.hgr.zx02

####

fc_iipix.hgr:	fc_iipix.png
	$(PNG_TO_HGR) fc_iipix.png > fc_iipix.hgr

fc_iipix.hgr.zx02:	fc_iipix.hgr
	$(ZX02) fc_iipix.hgr fc_iipix.hgr.zx02

####

clean:
	rm -f *~ *.zx02
