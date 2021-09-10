
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	trogdor_graphics.inc


trogdor_graphics.inc:	\
	trogdor_cave.lzsa \
	trogdor_open.lzsa \
	trogdor_flame1.lzsa \
	trogdor_flame2.lzsa
	echo "trogdor_cave_lzsa: .incbin \"trogdor_cave.lzsa\"" > trogdor_graphics.inc
	echo "trogdor_open_lzsa: .incbin \"trogdor_open.lzsa\"" >> trogdor_graphics.inc
	echo "trogdor_flame1_lzsa: .incbin \"trogdor_flame1.lzsa\"" >> trogdor_graphics.inc
	echo "trogdor_flame2_lzsa: .incbin \"trogdor_flame2.lzsa\"" >> trogdor_graphics.inc

###

trogdor_cave.lzsa:	trogdor_cave.hgr
	$(LZSA) -r -f2 trogdor_cave.hgr trogdor_cave.lzsa

trogdor_cave.hgr:	trogdor_cave.png
	$(PNG2HGR) trogdor_cave.png > trogdor_cave.hgr

###

trogdor_open.lzsa:	trogdor_open.hgr
	$(LZSA) -r -f2 trogdor_open.hgr trogdor_open.lzsa

trogdor_open.hgr:	trogdor_open.png
	$(PNG2HGR) trogdor_open.png > trogdor_open.hgr

###

trogdor_flame1.lzsa:	trogdor_flame1.hgr
	$(LZSA) -r -f2 trogdor_flame1.hgr trogdor_flame1.lzsa

trogdor_flame1.hgr:	trogdor_flame1.png
	$(PNG2HGR) trogdor_flame1.png > trogdor_flame1.hgr

###

trogdor_flame2.lzsa:	trogdor_flame2.hgr
	$(LZSA) -r -f2 trogdor_flame2.hgr trogdor_flame2.lzsa

trogdor_flame2.hgr:	trogdor_flame2.png
	$(PNG2HGR) trogdor_flame2.png > trogdor_flame2.hgr


###


clean:	
	rm -f *~ trogdor_graphics.inc *.lzsa *.gr *.hgr

