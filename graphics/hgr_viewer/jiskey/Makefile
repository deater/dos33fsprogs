
PNG2RLE = ../../../../utils/gr-utils/png2rle
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../../utils/bmp2dhr/b2d

all:	graphics.inc


graphics.inc:	\
	mona.lzsa
	echo "mona_lzsa: .incbin \"mona.lzsa\"" > graphics.inc


###

mona.lzsa:	mona.hgr
	$(LZSA) -r -f2 mona.hgr mona.lzsa

mona.hgr:	mona.png
	$(PNG2HGR) mona.png > mona.hgr

###


clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr

