
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	game_over_graphics.inc


game_over_graphics.inc:	\
	game_over.lzsa \
	videlectrix.lzsa
	echo "game_over_lzsa: .incbin \"game_over.lzsa\"" > game_over_graphics.inc
	echo "videlectrix_lzsa: .incbin \"videlectrix.lzsa\"" >> game_over_graphics.inc


###

videlectrix.lzsa:	videlectrix.hgr
	$(LZSA) -r -f2 videlectrix.hgr videlectrix.lzsa

videlectrix.hgr:	videlectrix.png
	$(PNG2HGR) videlectrix.png > videlectrix.hgr

###

game_over.lzsa:	game_over.hgr
	$(LZSA) -r -f2 game_over.hgr game_over.lzsa

game_over.hgr:	game_over.png
	$(PNG2HGR) game_over.png > game_over.hgr




###


clean:	
	rm -f *~ game_over_graphics.inc *.lzsa *.gr *.hgr

