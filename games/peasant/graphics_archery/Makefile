
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	archery_graphics.inc


###

archery_graphics.inc:	\
	target.lzsa
	echo "target_lzsa: .incbin \"target.lzsa\"" > archery_graphics.inc

###

target.lzsa:	target.hgr
	$(LZSA) -r -f2 target.hgr target.lzsa

target.hgr:	target.png
	$(PNG2HGR) target.png > target.hgr


####


clean:	
	rm -f *~ archery_graphics.inc *.lzsa *.gr *.hgr

