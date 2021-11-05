
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	map_graphics.inc


###

map_graphics.inc:	\
	map.lzsa
	echo "map_lzsa: .incbin \"map.lzsa\"" > map_graphics.inc

###

map.lzsa:	map.hgr
	$(LZSA) -r -f2 map.hgr map.lzsa

map.hgr:	map.png
	$(PNG2HGR) map.png > map.hgr


####


clean:	
	rm -f *~ map_graphics.inc *.lzsa *.gr *.hgr

