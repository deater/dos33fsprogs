
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	title_graphics.inc


title_graphics.inc:	\
	peasant_title.lzsa \
	tips.lzsa
	echo "title_lzsa: .incbin \"peasant_title.lzsa\"" > title_graphics.inc
	echo "tips_lzsa: .incbin \"tips.lzsa\"" >> title_graphics.inc

###

peasant_title.lzsa:	peasant_title.hgr
	$(LZSA) -r -f2 peasant_title.hgr peasant_title.lzsa

peasant_title.hgr:	peasant_title.png
	$(PNG2HGR) peasant_title.png > peasant_title.hgr

###

tips.lzsa:	tips.hgr
	$(LZSA) -r -f2 tips.hgr tips.lzsa

tips.hgr:	tips.png
	$(PNG2HGR) tips.png > tips.hgr

###


clean:	
	rm -f *~ title_graphics.inc *.lzsa *.gr *.hgr

