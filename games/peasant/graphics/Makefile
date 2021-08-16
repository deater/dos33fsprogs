
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_intro.inc graphics.inc


graphics_intro.inc:	\
	cottage.lzsa \
	lake_e.lzsa \
	lake_w.lzsa \
	river.lzsa \
	knight.lzsa
	echo "cottage_lzsa: .incbin \"cottage.lzsa\"" > graphics_intro.inc
	echo "lake_w_lzsa: .incbin \"lake_w.lzsa\"" >> graphics_intro.inc
	echo "lake_e_lzsa: .incbin \"lake_e.lzsa\"" >> graphics_intro.inc
	echo "river_lzsa: .incbin \"river.lzsa\"" >> graphics_intro.inc
	echo "knight_lzsa: .incbin \"knight.lzsa\"" >> graphics_intro.inc
	echo "waterfall_lzsa: .incbin \"waterfall.lzsa\"" >> graphics_intro.inc

###

graphics.inc:	\
	cottage.lzsa \
	lake_e.lzsa \
	lake_w.lzsa \
	river.lzsa \
	knight.lzsa \
	waterfall.lzsa \
	inn.lzsa \
	todo.lzsa
	echo "cottage_lzsa: .incbin \"cottage.lzsa\"" > graphics.inc
	echo "lake_w_lzsa: .incbin \"lake_w.lzsa\"" >> graphics.inc
	echo "lake_e_lzsa: .incbin \"lake_e.lzsa\"" >> graphics.inc
	echo "river_lzsa: .incbin \"river.lzsa\"" >> graphics.inc
	echo "knight_lzsa: .incbin \"knight.lzsa\"" >> graphics.inc
	echo "waterfall_lzsa: .incbin \"waterfall.lzsa\"" >> graphics.inc
	echo "inn_lzsa: .incbin \"inn.lzsa\"" >> graphics.inc
	echo "todo_lzsa: .incbin \"todo.lzsa\"" >> graphics.inc


###

videlectrix.lzsa:	videlectrix.hgr
	$(LZSA) -r -f2 videlectrix.hgr videlectrix.lzsa

videlectrix.hgr:	videlectrix.png
	$(PNG2HGR) videlectrix.png > videlectrix.hgr

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

cottage.lzsa:	cottage.hgr
	$(LZSA) -r -f2 cottage.hgr cottage.lzsa

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr

###

lake_w.lzsa:	lake_w.hgr
	$(LZSA) -r -f2 lake_w.hgr lake_w.lzsa

lake_w.hgr:	lake_w.png
	$(PNG2HGR) lake_w.png > lake_w.hgr

###

lake_e.lzsa:	lake_e.hgr
	$(LZSA) -r -f2 lake_e.hgr lake_e.lzsa

lake_e.hgr:	lake_e.png
	$(PNG2HGR) lake_e.png > lake_e.hgr

###

river.lzsa:	river.hgr
	$(LZSA) -r -f2 river.hgr river.lzsa

river.hgr:	river.png
	$(PNG2HGR) river.png > river.hgr

###

knight.lzsa:	knight.hgr
	$(LZSA) -r -f2 knight.hgr knight.lzsa

knight.hgr:	knight.png
	$(PNG2HGR) knight.png > knight.hgr

###

waterfall.lzsa:	waterfall.hgr
	$(LZSA) -r -f2 waterfall.hgr waterfall.lzsa

waterfall.hgr:	waterfall.png
	$(PNG2HGR) waterfall.png > waterfall.hgr

###

inn.lzsa:	inn.hgr
	$(LZSA) -r -f2 inn.hgr inn.lzsa

inn.hgr:	inn.png
	$(PNG2HGR) inn.png > inn.hgr

###

todo.lzsa:	todo.hgr
	$(LZSA) -r -f2 todo.hgr todo.lzsa

todo.hgr:	todo.png
	$(PNG2HGR) todo.png > todo.hgr


###


clean:	
	rm -f *~ graphics.inc *.lzsa *.gr *.hgr

