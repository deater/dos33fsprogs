
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	cliff_graphics.inc


cliff_graphics.inc:	\
	cliff_base.lzsa
	echo "cliff_base_lzsa: .incbin \"cliff_base.lzsa\"" > cliff_graphics.inc

###

cliff_base.lzsa:	cliff_base.hgr
	$(LZSA) -r -f2 cliff_base.hgr cliff_base.lzsa

cliff_base.hgr:	cliff_base.png
	$(PNG2HGR) cliff_base.png > cliff_base.hgr

###


clean:	
	rm -f *~ trogdor_graphics.inc *.lzsa *.gr *.hgr

