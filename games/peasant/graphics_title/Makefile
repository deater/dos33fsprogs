
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
B2D = ../../../utils/bmp2dhr/b2d

all:	title_graphics.inc


title_graphics.inc:	\
	peasant_title.zx02 \
	peasant_title_trogfree.zx02 \
	tips.zx02
	echo "title_zx02: .incbin \"peasant_title.zx02\"" > title_graphics.inc
	echo "title_trogfree_zx02: .incbin \"peasant_title_trogfree.zx02\"" >> title_graphics.inc
	echo "tips_zx02: .incbin \"tips.zx02\"" >> title_graphics.inc

###

peasant_title.zx02:	peasant_title.hgr
	$(ZX02) peasant_title.hgr peasant_title.zx02

peasant_title.hgr:	peasant_title.png
	$(PNG2HGR) peasant_title.png > peasant_title.hgr

###

peasant_title_trogfree.zx02:	peasant_title_trogfree.hgr
	$(ZX02) peasant_title_trogfree.hgr peasant_title_trogfree.zx02

peasant_title_trogfree.hgr:	peasant_title_trogfree.png
	$(PNG2HGR) peasant_title_trogfree.png > peasant_title_trogfree.hgr


###

tips.zx02:	tips.hgr
	$(ZX02) tips.hgr tips.zx02

tips.hgr:	tips.png
	$(PNG2HGR) tips.png > tips.hgr

###


clean:	
	rm -f *~ title_graphics.inc *.zx02 *.gr *.hgr

