
PNG2RLE = ../../../../utils/gr-utils/png2rle
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../../utils/bmp2dhr/b2d

all:	outline.inc


outline.inc:	\
	outline_space.lzsa
	echo "outline_space_lzsa: .incbin \"outline_space.lzsa\"" > outline.inc


###

outline_space.lzsa:	outline_space.hgr
	$(LZSA) -r -f2 outline_space.hgr outline_space.lzsa

outline_space.hgr:	outline_space.png
	$(PNG2HGR) outline_space.png > outline_space.hgr

###


clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr

