
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	copy_graphics.inc


copy_graphics.inc:	\
	trogdor.lzsa \
	game_over.lzsa
	echo "trogdor_lzsa: .incbin \"trogdor.lzsa\"" > copy_graphics.inc
	echo "game_over_lzsa: .incbin \"game_over.lzsa\"" >> copy_graphics.inc


###

trogdor.lzsa:	trogdor.hgr
	$(LZSA) -r -f2 trogdor.hgr trogdor.lzsa

trogdor.hgr:	trogdor.png
	$(PNG2HGR) trogdor.png > trogdor.hgr

###

game_over.lzsa:	game_over.hgr
	$(LZSA) -r -f2 game_over.hgr game_over.lzsa

game_over.hgr:	game_over.png
	$(PNG2HGR) game_over.png > game_over.hgr




###


clean:	
	rm -f *~ copy_graphics.inc *.lzsa *.gr *.hgr

