
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	ending_graphics.inc


ending_graphics.inc:	\
	trogdor_cave.lzsa \
	lake_e_boat.lzsa \
	waterfall.lzsa \
	jhonka.lzsa \
	cottage.lzsa \
	the_end.lzsa
	echo "trogdor_cave_lzsa: .incbin \"trogdor_cave.lzsa\"" > ending_graphics.inc
	echo "lake_e_boat_lzsa: .incbin \"lake_e_boat.lzsa\"" >> ending_graphics.inc
	echo "waterfall_lzsa: .incbin \"waterfall.lzsa\"" >> ending_graphics.inc
	echo "jhonka_lzsa: .incbin \"jhonka.lzsa\"" >> ending_graphics.inc
	echo "cottage_lzsa: .incbin \"cottage.lzsa\"" >> ending_graphics.inc
	echo "the_end_lzsa: .incbin \"the_end.lzsa\"" >> ending_graphics.inc


###

trogdor_cave.lzsa:	trogdor_cave.hgr
	$(LZSA) -r -f2 trogdor_cave.hgr trogdor_cave.lzsa

trogdor_cave.hgr:	trogdor_cave.png
	$(PNG2HGR) trogdor_cave.png > trogdor_cave.hgr

###

lake_e_boat.lzsa:	lake_e_boat.hgr
	$(LZSA) -r -f2 lake_e_boat.hgr lake_e_boat.lzsa

lake_e_boat.hgr:	lake_e_boat.png
	$(PNG2HGR) lake_e_boat.png > lake_e_boat.hgr

###

waterfall.lzsa:	waterfall.hgr
	$(LZSA) -r -f2 waterfall.hgr waterfall.lzsa

waterfall.hgr:	waterfall.png
	$(PNG2HGR) waterfall.png > waterfall.hgr

###

jhonka.lzsa:	jhonka.hgr
	$(LZSA) -r -f2 jhonka.hgr jhonka.lzsa

jhonka.hgr:	jhonka.png
	$(PNG2HGR) jhonka.png > jhonka.hgr

###

cottage.lzsa:	cottage.hgr
	$(LZSA) -r -f2 cottage.hgr cottage.lzsa

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr


###

the_end.lzsa:	the_end.hgr
	$(LZSA) -r -f2 the_end.hgr the_end.lzsa

the_end.hgr:	the_end.png
	$(PNG2HGR) the_end.png > the_end.hgr




###


clean:	
	rm -f *~ copy_graphics.inc *.lzsa *.gr *.hgr

