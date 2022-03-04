PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_test.inc

###

graphics_test.inc:	\
	level1.lzsa \
	level2.lzsa \
	level2_actual.lzsa
	echo "level1_lzsa: .incbin \"level1.lzsa\"" > graphics_test.inc
	echo "level2_lzsa: .incbin \"level2.lzsa\"" >> graphics_test.inc
	echo "level2_actual_lzsa: .incbin \"level2_actual.lzsa\"" >> graphics_test.inc

###

level1.lzsa:	level1.hgr
	$(LZSA) -r -f2 level1.hgr level1.lzsa

level1.hgr:	level1.png
	$(PNG2HGR) level1.png > level1.hgr

###

level2.lzsa:	level2.hgr
	$(LZSA) -r -f2 level2.hgr level2.lzsa

level2.hgr:	level2.png
	$(PNG2HGR) level2.png > level2.hgr

###

level2_actual.lzsa:	level2_actual.hgr
	$(LZSA) -r -f2 level2_actual.hgr level2_actual.lzsa

level2_actual.hgr:	level2_actual.png
	$(PNG2HGR) level2_actual.png > level2_actual.hgr

####

clean:	
	rm -f *~ graphics_test.inc \
		*.lzsa *.gr *.hgr

