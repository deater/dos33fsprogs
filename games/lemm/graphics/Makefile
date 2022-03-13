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
	$(HGR_SPRITE) -s -l lflame1_sprite sprites.png 7  29 13 35 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame2_sprite sprites.png 7  36 13 41 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame3_sprite sprites.png 7  43 13 48 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame4_sprite sprites.png 7  50 13 55 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame1_sprite sprites.png 21 29 27 35 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame2_sprite sprites.png 21 36 27 41 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame3_sprite sprites.png 21 43 27 48 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame4_sprite sprites.png 21 50 27 55 >> sprites.inc
	$(HGR_SPRITE) -s -l door1_sprite sprites.png    7 57 55 69 >> sprites.inc
	$(HGR_SPRITE) -s -l door2_sprite sprites.png    7 76 55 91 >> sprites.inc
	$(HGR_SPRITE) -s -l door3_sprite sprites.png    7 98 55 114 >> sprites.inc
	$(HGR_SPRITE) -s -l door4_sprite sprites.png    7 118 55 137 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall1_sprite sprites.png  14 161  20 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall2_sprite sprites.png  28 161  34 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall3_sprite sprites.png  42 161  48 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall4_sprite sprites.png  56 161  62 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall1_sprite sprites.png  70 161  76 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall2_sprite sprites.png  84 161  90 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall3_sprite sprites.png  98 161 104 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall4_sprite sprites.png 112 161 118 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig1_sprite sprites.png  14 142  20 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig2_sprite sprites.png  28 142  34 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig3_sprite sprites.png  42 142  48 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig4_sprite sprites.png  56 142  62 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig5_sprite sprites.png  70 142  76 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig6_sprite sprites.png  84 142  90 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig7_sprite sprites.png  98 142 104 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig8_sprite sprites.png 112 142 118 153 >> sprites.inc


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

