
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	game_over_graphics.inc

###

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

