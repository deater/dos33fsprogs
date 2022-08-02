
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	map_graphics.inc


###

map_graphics.inc:	\
	map.zx02
	echo "map_zx02: .incbin \"map.zx02\"" > map_graphics.inc

###

map.zx02:	map.hgr
	$(ZX02) -f map.hgr map.zx02

map.hgr:	map.png
	$(PNG2HGR) map.png > map.hgr


####


clean:	
	rm -f *~ map_graphics.inc *.zx02 *.gr *.hgr

