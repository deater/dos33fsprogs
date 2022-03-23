PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	graphics_test.inc \
	graphics_level1.inc \
	graphics_level2.inc \
	graphics_level3.inc \
	graphics_level4.inc \
	graphics_level5.inc \
	sprites.inc

###

graphics_test.inc:	\
	level1.lzsa \
	level5.lzsa \
	level5_fine.lzsa
	echo "level1_lzsa: .incbin \"level1.lzsa\"" > graphics_test.inc
	echo "level5_lzsa: .incbin \"level5.lzsa\"" >> graphics_test.inc
	echo "level5_fine_lzsa: .incbin \"level5_fine.lzsa\"" >> graphics_test.inc


graphics_level1.inc:	\
	level1.lzsa \
	level1_preview.lzsa
	echo "level1_lzsa: .incbin \"level1.lzsa\"" > graphics_level1.inc
	echo "level1_preview_lzsa: .incbin \"level1_preview.lzsa\"" >> graphics_level1.inc

graphics_level2.inc:	\
	level2.lzsa \
	level2_preview.lzsa
	echo "level2_lzsa: .incbin \"level2.lzsa\"" > graphics_level2.inc
	echo "level2_preview_lzsa: .incbin \"level2_preview.lzsa\"" >> graphics_level2.inc

graphics_level3.inc:	\
	level3.lzsa \
	level3_preview.lzsa
	echo "level3_lzsa: .incbin \"level3.lzsa\"" > graphics_level3.inc
	echo "level3_preview_lzsa: .incbin \"level3_preview.lzsa\"" >> graphics_level3.inc



graphics_level4.inc:	\
	level4.lzsa \
	level4_preview.lzsa
	echo "level4_lzsa: .incbin \"level4.lzsa\"" > graphics_level4.inc
	echo "level4_preview_lzsa: .incbin \"level4_preview.lzsa\"" >> graphics_level4.inc

graphics_level5.inc:	\
	level5.lzsa \
	level5_preview.lzsa
	echo "level5_lzsa: .incbin \"level5.lzsa\"" > graphics_level5.inc
	echo "level5_preview_lzsa: .incbin \"level5_preview.lzsa\"" >> graphics_level5.inc

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
	$(HGR_SPRITE) -s -l blank_sprite sprites.png 0   1 6 16 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lflame1_sprite sprites.png 7  29 13 35 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame2_sprite sprites.png 7  36 13 41 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame3_sprite sprites.png 7  43 13 48 >> sprites.inc
	$(HGR_SPRITE) -s -l lflame4_sprite sprites.png 7  50 13 55 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame1_sprite sprites.png 21 29 27 35 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame2_sprite sprites.png 21 36 27 41 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame3_sprite sprites.png 21 43 27 48 >> sprites.inc
	$(HGR_SPRITE) -s -l rflame4_sprite sprites.png 21 50 27 55 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l door1_sprite sprites.png    7 57 55 69 >> sprites.inc
	$(HGR_SPRITE) -s -l door2_sprite sprites.png    7 76 55 91 >> sprites.inc
	$(HGR_SPRITE) -s -l door3_sprite sprites.png    7 98 55 114 >> sprites.inc
	$(HGR_SPRITE) -s -l door4_sprite sprites.png    7 118 55 137 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l bdoor1_sprite sprites.png   63 57 104 69 >> sprites.inc
	$(HGR_SPRITE) -s -l bdoor2_sprite sprites.png   63 76 104 91 >> sprites.inc
	$(HGR_SPRITE) -s -l bdoor3_sprite sprites.png   63 98 104 114 >> sprites.inc
	$(HGR_SPRITE) -s -l bdoor4_sprite sprites.png   63 118 104 137 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rfall1_sprite sprites.png  14 161  20 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall2_sprite sprites.png  28 161  34 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall3_sprite sprites.png  42 161  48 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall4_sprite sprites.png  56 161  62 170 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lfall1_sprite sprites.png  70 161  76 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall2_sprite sprites.png  84 161  90 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall3_sprite sprites.png  98 161 104 170 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall4_sprite sprites.png 112 161 118 170 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_dig1_sprite sprites.png  14 142  20 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig2_sprite sprites.png  28 142  34 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig3_sprite sprites.png  42 142  48 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig4_sprite sprites.png  56 142  62 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig5_sprite sprites.png  70 142  76 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig6_sprite sprites.png  84 142  90 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig7_sprite sprites.png  98 142 104 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig8_sprite sprites.png 112 142 118 153 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lwalk1_sprite sprites.png 140 159 146 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk2_sprite sprites.png 154 159 160 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk3_sprite sprites.png 168 159 174 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk4_sprite sprites.png 182 159 188 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk5_sprite sprites.png 196 159 202 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk6_sprite sprites.png 210 159 216 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk7_sprite sprites.png 224 159 230 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk8_sprite sprites.png 238 159 244 169 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rwalk1_sprite sprites.png 140 143 146 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk2_sprite sprites.png 154 143 160 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk3_sprite sprites.png 168 143 174 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk4_sprite sprites.png 182 143 188 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk5_sprite sprites.png 196 143 202 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk6_sprite sprites.png 210 143 216 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk7_sprite sprites.png 224 143 230 153 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk8_sprite sprites.png 238 143 244 153 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_explode1_sprite sprites.png  14 175  20 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode2_sprite sprites.png  42 175  48 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode3_sprite sprites.png  56 175  62 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode4_sprite sprites.png  70 175  76 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode5_sprite sprites.png  84 175  90 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode6_sprite sprites.png  98 175 104 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode7_sprite sprites.png 112 175 118 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode8_sprite sprites.png 140 175 146 185 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode9_sprite sprites.png 168 175 174 185 >> sprites.inc
	$(HGR_SPRITE) -s -l explosion_sprite sprites.png 252 172 265 187 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l countdown1_sprite sprites.png  140 136 146 141 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown2_sprite sprites.png  154 136 160 141 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown3_sprite sprites.png  168 136 174 141 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown4_sprite sprites.png  182 136 188 141 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown5_sprite sprites.png  196 136 202 141 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_umbrella1_sprite sprites.png 140 117 146 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella2_sprite sprites.png 154 117 160 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella3_sprite sprites.png 168 117 174 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella4_sprite sprites.png 182 117 188 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella5_sprite sprites.png 196 117 202 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella6_sprite sprites.png 210 117 216 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella7_sprite sprites.png 224 117 230 132 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella8_sprite sprites.png 238 117 244 132 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_splat1_sprite sprites.png 140 75 146 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat2_sprite sprites.png 154 75 160 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat3_sprite sprites.png 168 75 174 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat4_sprite sprites.png 182 75 188 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat5_sprite sprites.png 196 75 202 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat6_sprite sprites.png 210 75 216 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat7_sprite sprites.png 224 75 230 83 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat8_sprite sprites.png 238 75 244 83 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_stopper1_sprite sprites.png 154  1 160 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper2_sprite sprites.png 168  1 174 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper3_sprite sprites.png 182  1 188 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper4_sprite sprites.png 196  1 202 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper5_sprite sprites.png 210  1 216 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper6_sprite sprites.png 224  1 230 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper7_sprite sprites.png 238  1 244 11 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper8_sprite sprites.png 252  1 258 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper9_sprite sprites.png 154  13 160 23 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper10_sprite sprites.png 168  13 174 23 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper11_sprite sprites.png 182  13 188 23 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper12_sprite sprites.png 196  13 202 23 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper13_sprite sprites.png 210  13 216 23 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper14_sprite sprites.png 224  13 230 23 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper15_sprite sprites.png 238  13 244 23 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper16_sprite sprites.png 252  13 258 23 >> sprites.inc












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

level2_preview.lzsa:	level2_preview.hgr
	$(LZSA) -r -f2 level2_preview.hgr level2_preview.lzsa

level2_preview.hgr:	level2_preview.png
	$(PNG2HGR) level2_preview.png > level2_preview.hgr

###

level3.lzsa:	level3.hgr
	$(LZSA) -r -f2 level3.hgr level3.lzsa

level3.hgr:	level3.png
	$(PNG2HGR) level3.png > level3.hgr

###


level3_preview.lzsa:	level3_preview.hgr
	$(LZSA) -r -f2 level3_preview.hgr level3_preview.lzsa

level3_preview.hgr:	level3_preview.png
	$(PNG2HGR) level3_preview.png > level3_preview.hgr

###

level4.lzsa:	level4.hgr
	$(LZSA) -r -f2 level4.hgr level4.lzsa

level4.hgr:	level4.png
	$(PNG2HGR) level4.png > level4.hgr

###


level4_preview.lzsa:	level4_preview.hgr
	$(LZSA) -r -f2 level4_preview.hgr level4_preview.lzsa

level4_preview.hgr:	level4_preview.png
	$(PNG2HGR) level4_preview.png > level4_preview.hgr


###

level5.lzsa:	level5.hgr
	$(LZSA) -r -f2 level5.hgr level5.lzsa

level5.hgr:	level5.png
	$(PNG2HGR) level5.png > level5.hgr

###


level5_preview.lzsa:	level5_preview.hgr
	$(LZSA) -r -f2 level5_preview.hgr level5_preview.lzsa

level5_preview.hgr:	level5_preview.png
	$(PNG2HGR) level5_preview.png > level5_preview.hgr

###

level5_fine.lzsa:	level5_fine.hgr
	$(LZSA) -r -f2 level5_fine.hgr level5_fine.lzsa

level5_fine.hgr:	level5_fine.png
	$(PNG2HGR) level5_fine.png > level5_fine.hgr

####

clean:	
	rm -f *~ graphics_test.inc sprites.inc \
		*.lzsa *.gr *.hgr

