
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_intro.inc \
	graphics_peasant1.inc graphics_peasant2.inc graphics_peasant3.inc \
	graphics_peasant4.inc


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

graphics_peasant1.inc:	\
	todo.lzsa \
	waterfall.lzsa
	echo "todo_lzsa: .incbin \"todo.lzsa\"" > graphics_peasant1.inc
	echo "waterfall_lzsa: .incbin \"waterfall.lzsa\"" >> graphics_peasant1.inc

###

graphics_peasant2.inc:	\
	todo.lzsa \
	river.lzsa \
	knight.lzsa
	echo "todo_lzsa: .incbin \"todo.lzsa\"" > graphics_peasant2.inc
	echo "river_lzsa: .incbin \"river.lzsa\"" >> graphics_peasant2.inc
	echo "knight_lzsa: .incbin \"knight.lzsa\"" >> graphics_peasant2.inc

###

graphics_peasant3.inc:	\
	todo.lzsa \
	cottage.lzsa \
	lake_e.lzsa \
	lake_w.lzsa \
	inn.lzsa
	echo "todo_lzsa: .incbin \"todo.lzsa\"" > graphics_peasant3.inc
	echo "cottage_lzsa: .incbin \"cottage.lzsa\"" >> graphics_peasant3.inc
	echo "lake_w_lzsa: .incbin \"lake_w.lzsa\"" >> graphics_peasant3.inc
	echo "lake_e_lzsa: .incbin \"lake_e.lzsa\"" >> graphics_peasant3.inc
	echo "inn_lzsa: .incbin \"inn.lzsa\"" >> graphics_peasant3.inc

###

graphics_peasant4.inc:	\
	todo.lzsa \
	lady_cottage.lzsa \
	crooked_tree.lzsa
	echo "todo_lzsa: .incbin \"todo.lzsa\"" > graphics_peasant4.inc
	echo "lady_cottage_lzsa: .incbin \"lady_cottage.lzsa\"" >> graphics_peasant4.inc
	echo "crooked_tree_lzsa: .incbin \"crooked_tree.lzsa\"" >> graphics_peasant4.inc

###


cottage.lzsa:	cottage.hgr
	$(LZSA) -r -f2 cottage.hgr cottage.lzsa

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr

###

crooked_tree.lzsa:	crooked_tree.hgr
	$(LZSA) -r -f2 crooked_tree.hgr crooked_tree.lzsa

crooked_tree.hgr:	crooked_tree.png
	$(PNG2HGR) crooked_tree.png > crooked_tree.hgr

###

lady_cottage.lzsa:	lady_cottage.hgr
	$(LZSA) -r -f2 lady_cottage.hgr lady_cottage.lzsa

lady_cottage.hgr:	lady_cottage.png
	$(PNG2HGR) lady_cottage.png > lady_cottage.hgr


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

