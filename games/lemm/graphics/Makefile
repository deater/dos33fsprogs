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
	graphics_level6.inc \
	graphics_level7.inc \
	graphics_level8.inc \
	graphics_level9.inc \
	graphics_level10.inc \
	sprites.inc \
	l6_animation.inc



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

graphics_level6.inc:	\
	level6.lzsa \
	level6_preview.lzsa
	echo "level6_lzsa: .incbin \"level6.lzsa\"" > graphics_level6.inc
	echo "level6_preview_lzsa: .incbin \"level6_preview.lzsa\"" >> graphics_level6.inc

graphics_level7.inc:	\
	level7.lzsa \
	level7_preview.lzsa
	echo "level7_lzsa: .incbin \"level7.lzsa\"" > graphics_level7.inc
	echo "level7_preview_lzsa: .incbin \"level7_preview.lzsa\"" >> graphics_level7.inc

graphics_level8.inc:	\
	level8.lzsa \
	level8_preview.lzsa
	echo "level8_lzsa: .incbin \"level8.lzsa\"" > graphics_level8.inc
	echo "level8_preview_lzsa: .incbin \"level8_preview.lzsa\"" >> graphics_level8.inc

graphics_level9.inc:	\
	level9.lzsa \
	level9_preview.lzsa
	echo "level9_lzsa: .incbin \"level9.lzsa\"" > graphics_level9.inc
	echo "level9_preview_lzsa: .incbin \"level9_preview.lzsa\"" >> graphics_level9.inc

graphics_level10.inc:	\
	level10.lzsa \
	level10_preview.lzsa
	echo "level10_lzsa: .incbin \"level10.lzsa\"" > graphics_level10.inc
	echo "level10_preview_lzsa: .incbin \"level10_preview.lzsa\"" >> graphics_level10.inc


###

l6_animation.inc:	level_animations.png
	$(HGR_SPRITE) -s -l flame0_sprite level_animations.png  42   3  62 11 > l6_animation.inc
	$(HGR_SPRITE) -s -l flame1_sprite level_animations.png  28  14  62 23 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame2_sprite level_animations.png  21  25  62 38 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame3_sprite level_animations.png  21  42  62 52 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame4_sprite level_animations.png  14  56  41 63 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame5_sprite level_animations.png  14  68  34 77 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame6_sprite level_animations.png   0  85  27 93 >> l6_animation.inc
	$(HGR_SPRITE) -s -l flame7_sprite level_animations.png  28  86  34 87 >> l6_animation.inc



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
	$(HGR_SPRITE) -s -l lemming_rfall1_sprite sprites.png  14 171  20 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall2_sprite sprites.png  28 171  34 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall3_sprite sprites.png  42 171  48 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rfall4_sprite sprites.png  56 171  62 180 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lfall1_sprite sprites.png  70 171  76 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall2_sprite sprites.png  84 171  90 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall3_sprite sprites.png  98 171 104 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lfall4_sprite sprites.png 112 171 118 180 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_dig1_sprite sprites.png  14 157  20 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig2_sprite sprites.png  28 157  34 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig3_sprite sprites.png  42 157  48 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig4_sprite sprites.png  56 157  62 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig5_sprite sprites.png  70 157  76 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig6_sprite sprites.png  84 157  90 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig7_sprite sprites.png  98 157 104 168 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_dig8_sprite sprites.png 112 157 118 168 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lwalk1_sprite sprites.png 140 170 146 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk2_sprite sprites.png 154 170 160 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk3_sprite sprites.png 168 170 174 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk4_sprite sprites.png 182 170 188 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk5_sprite sprites.png 196 170 202 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk6_sprite sprites.png 210 170 216 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk7_sprite sprites.png 224 170 230 180 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lwalk8_sprite sprites.png 238 170 244 180 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rwalk1_sprite sprites.png 140 159 146 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk2_sprite sprites.png 154 159 160 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk3_sprite sprites.png 168 159 174 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk4_sprite sprites.png 182 159 188 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk5_sprite sprites.png 196 159 202 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk6_sprite sprites.png 210 159 216 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk7_sprite sprites.png 224 159 230 169 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rwalk8_sprite sprites.png 238 159 244 169 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_explode1_sprite sprites.png  14 181  20 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode2_sprite sprites.png  42 181  48 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode3_sprite sprites.png  56 181  62 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode4_sprite sprites.png  70 181  76 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode5_sprite sprites.png  84 181  90 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode6_sprite sprites.png  98 181 104 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode7_sprite sprites.png 112 181 118 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode8_sprite sprites.png 140 181 146 191 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_explode9_sprite sprites.png 168 181 174 191 >> sprites.inc
	$(HGR_SPRITE) -s -l explosion_sprite sprites.png 252 172 265 187 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l countdown1_sprite sprites.png  140 153 146 158 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown2_sprite sprites.png  154 153 160 158 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown3_sprite sprites.png  168 153 174 158 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown4_sprite sprites.png  182 153 188 158 >> sprites.inc
	$(HGR_SPRITE) -s -l countdown5_sprite sprites.png  196 153 202 158 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_umbrella1_sprite sprites.png 140 137 146 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella2_sprite sprites.png 154 137 160 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella3_sprite sprites.png 168 137 174 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella4_sprite sprites.png 182 137 188 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella5_sprite sprites.png 196 137 202 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella6_sprite sprites.png 210 137 216 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella7_sprite sprites.png 224 137 230 152 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_umbrella8_sprite sprites.png 238 137 244 152 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_splat1_sprite sprites.png  14 147  20 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat2_sprite sprites.png  28 147  34 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat3_sprite sprites.png  42 147  48 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat4_sprite sprites.png  56 147  62 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat5_sprite sprites.png  70 147  76 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat6_sprite sprites.png  84 147  90 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat7_sprite sprites.png  98 147 104 155 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_splat8_sprite sprites.png 112 147 118 155 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_stopper1_sprite sprites.png 154  1 160 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper2_sprite sprites.png 168  1 174 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper3_sprite sprites.png 182  1 188 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper4_sprite sprites.png 196  1 202 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper5_sprite sprites.png 210  1 216 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper6_sprite sprites.png 224  1 230 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper7_sprite sprites.png 238  1 244 11 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper8_sprite sprites.png 252  1 258 11 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper9_sprite sprites.png  154 12 160 24 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper10_sprite sprites.png 168 12 174 24 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper11_sprite sprites.png 182 12 188 24 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper12_sprite sprites.png 196 12 202 24 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper13_sprite sprites.png 210 12 216 24 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_stopper14_sprite sprites.png 224 12 230 24 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper15_sprite sprites.png 238 12 244 24 >> sprites.inc
#	$(HGR_SPRITE) -s -l lemming_stopper16_sprite sprites.png 252 12 258 24 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rbasher1_sprite sprites.png 154 23 160 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher2_sprite sprites.png 168 23 174 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher3_sprite sprites.png 182 23 188 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher4_sprite sprites.png 196 23 202 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher5_sprite sprites.png 210 23 216 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher6_sprite sprites.png 224 23 230 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher7_sprite sprites.png 238 23 244 32 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbasher8_sprite sprites.png 252 23 258 32 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lbasher1_sprite sprites.png 154 33 160 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher2_sprite sprites.png 168 33 174 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher3_sprite sprites.png 182 33 188 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher4_sprite sprites.png 196 33 202 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher5_sprite sprites.png 210 33 216 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher6_sprite sprites.png 224 33 230 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher7_sprite sprites.png 238 33 244 42 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbasher8_sprite sprites.png 252 33 258 42 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rbuild1_sprite sprites.png 140 56 146 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild2_sprite sprites.png 154 56 160 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild3_sprite sprites.png 168 56 174 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild4_sprite sprites.png 182 56 188 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild5_sprite sprites.png 196 56 202 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild6_sprite sprites.png 210 56 216 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild7_sprite sprites.png 224 56 230 66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rbuild8_sprite sprites.png 238 56 244 66 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lbuild1_sprite sprites.png 140 67 146 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild2_sprite sprites.png 154 67 160 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild3_sprite sprites.png 168 67 174 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild4_sprite sprites.png 182 67 188 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild5_sprite sprites.png 196 67 202 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild6_sprite sprites.png 210 67 216 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild7_sprite sprites.png 224 67 230 77 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lbuild8_sprite sprites.png 238 67 244 77 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rpullup1_sprite sprites.png 140 103 146 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup2_sprite sprites.png 154 103 160 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup3_sprite sprites.png 168 103 174 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup4_sprite sprites.png 182 103 188 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup5_sprite sprites.png 196 103 202 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup6_sprite sprites.png 210 103 216 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup7_sprite sprites.png 224 103 230 113 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rpullup8_sprite sprites.png 238 103 244 113 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lpullup1_sprite sprites.png 140 91 146 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup2_sprite sprites.png 154 91 160 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup3_sprite sprites.png 168 91 174 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup4_sprite sprites.png 182 91 188 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup5_sprite sprites.png 196 91 202 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup6_sprite sprites.png 210 91 216 101>> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup7_sprite sprites.png 224 91 230 101 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lpullup8_sprite sprites.png 238 91 244 101 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rclimb1_sprite sprites.png 140 126 146 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb2_sprite sprites.png 154 126 160 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb3_sprite sprites.png 168 126 174 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb4_sprite sprites.png 182 126 188 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb5_sprite sprites.png 196 126 202 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb6_sprite sprites.png 210 126 216 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb7_sprite sprites.png 224 126 230 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rclimb8_sprite sprites.png 238 126 244 136 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lclimb1_sprite sprites.png 140 115 146 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb2_sprite sprites.png 154 115 160 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb3_sprite sprites.png 168 115 174 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb4_sprite sprites.png 182 115 188 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb5_sprite sprites.png 196 115 202 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb6_sprite sprites.png 210 115 216 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb7_sprite sprites.png 224 115 230 125 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lclimb8_sprite sprites.png 238 115 244 125 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lshrug1_sprite sprites.png 112 80 118 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lshrug2_sprite sprites.png 126 80 132 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rshrug1_sprite sprites.png 140 80 146 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rshrug2_sprite sprites.png 154 80 160 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug3_sprite sprites.png  168 80 174 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug4_sprite sprites.png  182 80 188 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug5_sprite sprites.png  196 80 202 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug6_sprite sprites.png  210 80 216 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug7_sprite sprites.png  224 80 230 89 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_shrug8_sprite sprites.png  238 80 244 89 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_rmine1_sprite sprites.png 252  54 258  66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine2_sprite sprites.png 252  68 258  80 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine3_sprite sprites.png 252  82 258  94 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine4_sprite sprites.png 252  96 258 108 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine5_sprite sprites.png 252 110 258 122 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine6_sprite sprites.png 252 124 258 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine7_sprite sprites.png 252 138 258 150 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_rmine8_sprite sprites.png 252 152 258 164 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l lemming_lmine1_sprite sprites.png 266  54 272  66 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine2_sprite sprites.png 266  68 272  80 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine3_sprite sprites.png 266  82 272  94 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine4_sprite sprites.png 266  96 272 108 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine5_sprite sprites.png 266 110 272 122 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine6_sprite sprites.png 266 124 272 136 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine7_sprite sprites.png 266 138 272 150 >> sprites.inc
	$(HGR_SPRITE) -s -l lemming_lmine8_sprite sprites.png 266 152 272 164 >> sprites.inc
	#
	$(HGR_SPRITE) -s -l little00_sprite sprites.png 140  19 146  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little01_sprite sprites.png 126  19 132  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little02_sprite sprites.png 112  19 116  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little03_sprite sprites.png  98  19 104  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little04_sprite sprites.png  84  19  90  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little05_sprite sprites.png  70  19  76  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little06_sprite sprites.png  56  19  62  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little07_sprite sprites.png  42  19  48  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little08_sprite sprites.png  28  19  34  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little09_sprite sprites.png  14  19  20  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little10_sprite sprites.png   0  19   6  27 >> sprites.inc
	$(HGR_SPRITE) -s -l little11_sprite sprites.png 140  28 146  36 >> sprites.inc
	$(HGR_SPRITE) -s -l little12_sprite sprites.png 126  28 132  36 >> sprites.inc
	$(HGR_SPRITE) -s -l little13_sprite sprites.png 112  28 116  36 >> sprites.inc
	$(HGR_SPRITE) -s -l little14_sprite sprites.png 140  37 146  45 >> sprites.inc
	$(HGR_SPRITE) -s -l little15_sprite sprites.png 126  37 132  45 >> sprites.inc
	$(HGR_SPRITE) -s -l little16_sprite sprites.png 112  37 116  45 >> sprites.inc
	$(HGR_SPRITE) -s -l little17_sprite sprites.png 140  46 146  54 >> sprites.inc
	$(HGR_SPRITE) -s -l little18_sprite sprites.png 126  46 132  54 >> sprites.inc
	$(HGR_SPRITE) -s -l little19_sprite sprites.png 112  46 116  54 >> sprites.inc
	$(HGR_SPRITE) -s -l little20_sprite sprites.png  98  46 104  54 >> sprites.inc


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

level6.lzsa:	level6.hgr
	$(LZSA) -r -f2 level6.hgr level6.lzsa

level6.hgr:	level6.png
	$(PNG2HGR) level6.png > level6.hgr

###


level6_preview.lzsa:	level6_preview.hgr
	$(LZSA) -r -f2 level6_preview.hgr level6_preview.lzsa

level6_preview.hgr:	level6_preview.png
	$(PNG2HGR) level6_preview.png > level6_preview.hgr

####

level7.lzsa:	level7.hgr
	$(LZSA) -r -f2 level7.hgr level7.lzsa

level7.hgr:	level7.png
	$(PNG2HGR) level7.png > level7.hgr

###


level7_preview.lzsa:	level7_preview.hgr
	$(LZSA) -r -f2 level7_preview.hgr level7_preview.lzsa

level7_preview.hgr:	level7_preview.png
	$(PNG2HGR) level7_preview.png > level7_preview.hgr

####

level8.lzsa:	level8.hgr
	$(LZSA) -r -f2 level8.hgr level8.lzsa

level8.hgr:	level8.png
	$(PNG2HGR) level8.png > level8.hgr

###


level8_preview.lzsa:	level8_preview.hgr
	$(LZSA) -r -f2 level8_preview.hgr level8_preview.lzsa

level8_preview.hgr:	level8_preview.png
	$(PNG2HGR) level8_preview.png > level8_preview.hgr

####

level9.lzsa:	level9.hgr
	$(LZSA) -r -f2 level9.hgr level9.lzsa

level9.hgr:	level9.png
	$(PNG2HGR) level9.png > level9.hgr

###


level9_preview.lzsa:	level9_preview.hgr
	$(LZSA) -r -f2 level9_preview.hgr level9_preview.lzsa

level9_preview.hgr:	level9_preview.png
	$(PNG2HGR) level9_preview.png > level9_preview.hgr

####

level10.lzsa:	level10.hgr
	$(LZSA) -r -f2 level10.hgr level10.lzsa

level10.hgr:	level10.png
	$(PNG2HGR) level10.png > level10.hgr

###


level10_preview.lzsa:	level10_preview.hgr
	$(LZSA) -r -f2 level10_preview.hgr level10_preview.lzsa

level10_preview.hgr:	level10_preview.png
	$(PNG2HGR) level10_preview.png > level10_preview.hgr



###

clean:	
	rm -f *~ graphics_test.inc sprites.inc \
		*.lzsa *.gr *.hgr

