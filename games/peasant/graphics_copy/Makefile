
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	copy_graphics.inc


copy_graphics.inc:	\
	trogdor.zx02 \
	game_over.zx02
	echo "trogdor_zx02: .incbin \"trogdor.zx02\"" > copy_graphics.inc
	echo "game_over_zx02: .incbin \"game_over.zx02\"" >> copy_graphics.inc


###

trogdor.zx02:	trogdor.hgr
	$(ZX02) -f trogdor.hgr trogdor.zx02

trogdor.hgr:	trogdor.png
	$(PNG2HGR) trogdor.png > trogdor.hgr

###

game_over.zx02:	game_over.hgr
	$(ZX02) -f game_over.hgr game_over.zx02

game_over.hgr:	game_over.png
	$(PNG2HGR) game_over.png > game_over.hgr




###


clean:	
	rm -f *~ copy_graphics.inc *.zx02 *.gr *.hgr

