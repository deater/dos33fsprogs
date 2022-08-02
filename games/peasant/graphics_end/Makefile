
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	ending_graphics.inc


ending_graphics.inc:	\
	lake_e_boat.zx02 \
	waterfall.zx02 \
	jhonka.zx02 \
	cottage.zx02 \
	the_end.zx02
	echo "lake_e_boat_zx02: .incbin \"lake_e_boat.zx02\"" > ending_graphics.inc
	echo "waterfall_zx02: .incbin \"waterfall.zx02\"" >> ending_graphics.inc
	echo "jhonka_zx02: .incbin \"jhonka.zx02\"" >> ending_graphics.inc
	echo "cottage_zx02: .incbin \"cottage.zx02\"" >> ending_graphics.inc
	echo "the_end_zx02: .incbin \"the_end.zx02\"" >> ending_graphics.inc

###

lake_e_boat.zx02:	lake_e_boat.hgr
	$(ZX02) -f lake_e_boat.hgr lake_e_boat.zx02

lake_e_boat.hgr:	lake_e_boat.png
	$(PNG2HGR) lake_e_boat.png > lake_e_boat.hgr

###

waterfall.zx02:	waterfall.hgr
	$(ZX02) -f waterfall.hgr waterfall.zx02

waterfall.hgr:	waterfall.png
	$(PNG2HGR) waterfall.png > waterfall.hgr

###

jhonka.zx02:	jhonka.hgr
	$(ZX02) -f jhonka.hgr jhonka.zx02

jhonka.hgr:	jhonka.png
	$(PNG2HGR) jhonka.png > jhonka.hgr

###

cottage.zx02:	cottage.hgr
	$(ZX02) -f cottage.hgr cottage.zx02

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr


###

the_end.zx02:	the_end.hgr
	$(ZX02) -f the_end.hgr the_end.zx02

the_end.hgr:	the_end.png
	$(PNG2HGR) the_end.png > the_end.hgr




###


clean:	
	rm -f *~ ending_graphics.inc *.zx02 *.gr *.hgr

