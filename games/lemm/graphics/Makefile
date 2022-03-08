PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	graphics_test.inc graphics_level1.inc sprites.inc

###

graphics_test.inc:	\
	level1.lzsa \
	level2.lzsa \
	level2_actual.lzsa
	echo "level1_lzsa: .incbin \"level1.lzsa\"" > graphics_test.inc
	echo "level2_lzsa: .incbin \"level2.lzsa\"" >> graphics_test.inc
	echo "level2_actual_lzsa: .incbin \"level2_actual.lzsa\"" >> graphics_test.inc


graphics_level1.inc:	\
	level1.lzsa \
	level1_preview.lzsa
	echo "level1_lzsa: .incbin \"level1.lzsa\"" > graphics_level1.inc
	echo "level1_preview_lzsa: .incbin \"level1_preview.lzsa\"" >> graphics_level1.inc

###

sprites.inc:	sprites.png
	$(HGR_SPRITE) -s -l big0_sprite sprites.png  14   1  20 16 > sprites.inc
	$(HGR_SPRITE) -s -l big1_sprite sprites.png  28   1  34 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big2_sprite sprites.png  42   1  48 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big3_sprite sprites.png  56   1  62 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big4_sprite sprites.png  70   1  76 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big5_sprite sprites.png  84   1  90 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big6_sprite sprites.png  98   1 104 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big7_sprite sprites.png 112   1 118 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big8_sprite sprites.png 126   1 132 16 >> sprites.inc
	$(HGR_SPRITE) -s -l big9_sprite sprites.png 140   1 146 16 >> sprites.inc



###

level1.lzsa:	level1.hgr
	$(LZSA) -r -f2 level1.hgr level1.lzsa

level1.hgr:	level1.png
	$(PNG2HGR) level1.png > level1.hgr

###

level1_preview.lzsa:	level1_preview.hgr
	$(LZSA) -r -f2 level1_preview.hgr level1_preview.lzsa

level1_preview.hgr:	level1_preview.png
	$(PNG2HGR) level1_preview.png > level1_preview.hgr


###

level2.lzsa:	level2.hgr
	$(LZSA) -r -f2 level2.hgr level2.lzsa

level2.hgr:	level2.png
	$(PNG2HGR) level2.png > level2.hgr

###

level2_actual.lzsa:	level2_actual.hgr
	$(LZSA) -r -f2 level2_actual.hgr level2_actual.lzsa

level2_actual.hgr:	level2_actual.png
	$(PNG2HGR) level2_actual.png > level2_actual.hgr

####

clean:	
	rm -f *~ graphics_test.inc sprites.inc \
		*.lzsa *.gr *.hgr

