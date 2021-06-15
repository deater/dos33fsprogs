
PNG2RLE = ../../../../utils/gr-utils/png2rle
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../../utils/bmp2dhr/b2d

all:	graphics.inc


graphics.inc:	\
	asteroid.page0.lzsa asteroid.page1.lzsa
	echo "asteroid0_lzsa: .incbin \"asteroid.page0.lzsa\"" > graphics.inc
	echo "asteroid1_lzsa: .incbin \"asteroid.page1.lzsa\"" >> graphics.inc


###

asteroid.page0.lzsa:	asteroid.page0
	$(LZSA) -r -f2 asteroid.page0 asteroid.page0.lzsa

asteroid.page1.lzsa:	asteroid.page1
	$(LZSA) -r -f2 asteroid.page1 asteroid.page1.lzsa

###


clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr

