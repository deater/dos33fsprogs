
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	game_over_graphics.inc game_over_animation.inc

game_over_animation.inc:       progression.png
	$(HGR_SPRITE) -s -l over_anim0  progression.png  35  4  48 33 > game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim1  progression.png  63  4  76 33 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim2  progression.png  91  4 104 33 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim3  progression.png 119  4 132 33 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim4  progression.png 147  4 160 33 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim5  progression.png 175  4 188 33 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim6  progression.png  35 36  48 65 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim7  progression.png  63 36  76 65 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim8  progression.png  91 36 104 65 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim9  progression.png 119 36 132 65 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim10 progression.png 147 36 160 65 >> game_over_animation.inc
	$(HGR_SPRITE) -s -l over_anim11 progression.png 175 36 188 65 >> game_over_animation.inc

game_over_graphics.inc:	\
	game_over.zx02 \
	videlectrix.zx02
	echo "game_over_zx02: .incbin \"game_over.zx02\"" > game_over_graphics.inc
	echo "videlectrix_zx02: .incbin \"videlectrix.zx02\"" >> game_over_graphics.inc


###

videlectrix.zx02:	videlectrix.hgr
	$(ZX02) -f videlectrix.hgr videlectrix.zx02

videlectrix.hgr:	videlectrix.png
	$(PNG2HGR) videlectrix.png > videlectrix.hgr

###

game_over.zx02:	game_over.hgr
	$(ZX02) -f game_over.hgr game_over.zx02

game_over.hgr:	game_over.png
	$(PNG2HGR) game_over.png > game_over.hgr




###


clean:	
	rm -f *~ game_over_graphics.inc game_over_animation.inc *.zx02 *.gr *.hgr

