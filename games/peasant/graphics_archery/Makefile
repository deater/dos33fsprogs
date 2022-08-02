
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	archery_graphics.inc


###

archery_graphics.inc:	\
	target.zx02
	echo "target_zx02: .incbin \"target.zx02\"" > archery_graphics.inc

###

target.zx02:	target.hgr
	$(ZX02) -f target.hgr target.zx02

target.hgr:	target.png
	$(PNG2HGR) target.png > target.hgr


####


clean:	
	rm -f *~ archery_graphics.inc *.zx02 *.gr *.hgr

