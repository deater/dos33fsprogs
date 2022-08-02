
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_intro.inc \
	graphics_peasant1.inc \
	graphics_peasant2.inc \
	graphics_peasant3.inc \
	graphics_peasant4.inc \
	priority_peasant1.inc \
	priority_intro.inc \
	priority_peasant2.inc \
	priority_peasant3.inc \
	priority_peasant4.inc


###

graphics_intro.inc:	\
	cottage.zx02 \
	lake_e.zx02 \
	lake_w.zx02 \
	river.zx02 \
	knight.zx02
	echo "cottage_zx02: .incbin \"cottage.zx02\"" > graphics_intro.inc
	echo "lake_w_zx02: .incbin \"lake_w.zx02\"" >> graphics_intro.inc
	echo "lake_e_zx02: .incbin \"lake_e.zx02\"" >> graphics_intro.inc
	echo "river_zx02: .incbin \"river.zx02\"" >> graphics_intro.inc
	echo "knight_zx02: .incbin \"knight.zx02\"" >> graphics_intro.inc

###

graphics_peasant1.inc:	\
	gary.zx02 \
	top_prints.zx02 \
	wishing_well.zx02 \
	leaning_tree.zx02 \
	waterfall.zx02
	echo "gary_zx02: .incbin \"gary.zx02\"" > graphics_peasant1.inc
	echo "top_prints_zx02: .incbin \"top_prints.zx02\"" >> graphics_peasant1.inc
	echo "wishing_well_zx02: .incbin \"wishing_well.zx02\"" >> graphics_peasant1.inc
	echo "leaning_tree_zx02: .incbin \"leaning_tree.zx02\"" >> graphics_peasant1.inc
	echo "waterfall_zx02: .incbin \"waterfall.zx02\"" >> graphics_peasant1.inc

###

graphics_peasant2.inc:	\
	haystack.zx02 \
	puddle.zx02 \
	archery.zx02 \
	river.zx02 \
	knight.zx02
	echo "haystack_zx02: .incbin \"haystack.zx02\"" > graphics_peasant2.inc
	echo "puddle_zx02: .incbin \"puddle.zx02\"" >> graphics_peasant2.inc
	echo "archery_zx02: .incbin \"archery.zx02\"" >> graphics_peasant2.inc
	echo "river_zx02: .incbin \"river.zx02\"" >> graphics_peasant2.inc
	echo "knight_zx02: .incbin \"knight.zx02\"" >> graphics_peasant2.inc

###

graphics_peasant3.inc:	\
	jhonka.zx02 \
	cottage.zx02 \
	lake_e.zx02 \
	lake_e_boat.zx02 \
	lake_w.zx02 \
	inn.zx02
	echo "jhonka_zx02: .incbin \"jhonka.zx02\"" > graphics_peasant3.inc
	echo "cottage_zx02: .incbin \"cottage.zx02\"" >> graphics_peasant3.inc
	echo "lake_w_zx02: .incbin \"lake_w.zx02\"" >> graphics_peasant3.inc
	echo "lake_e_zx02: .incbin \"lake_e.zx02\"" >> graphics_peasant3.inc
#	echo "lake_e_zx02: .incbin \"lake_e_boat.zx02\"" >> graphics_peasant3.inc
#	echo "lake_e_boat_zx02: .incbin \"lake_e_boat.zx02\"" >> graphics_peasant3.inc
	echo "inn_zx02: .incbin \"inn.zx02\"" >> graphics_peasant3.inc

###

graphics_peasant4.inc:	\
	empty_hut.zx02 \
	ned.zx02 \
	bottom_prints.zx02 \
	lady_cottage.zx02 \
	crooked_tree.zx02
	echo "empty_hut_zx02: .incbin \"empty_hut.zx02\"" > graphics_peasant4.inc
	echo "ned_zx02: .incbin \"ned.zx02\"" >> graphics_peasant4.inc
	echo "bottom_prints_zx02: .incbin \"bottom_prints.zx02\"" >> graphics_peasant4.inc
	echo "lady_cottage_zx02: .incbin \"lady_cottage.zx02\"" >> graphics_peasant4.inc
	echo "crooked_tree_zx02: .incbin \"crooked_tree.zx02\"" >> graphics_peasant4.inc

###########

priority_intro.inc:	\
	cottage_priority.zx02 \
	lake_w_priority.zx02 lake_e_priority.zx02 \
	river_priority.zx02 knight_priority.zx02
	echo "cottage_priority_zx02: .incbin \"cottage_priority.zx02\"" > priority_intro.inc
	echo "lake_w_priority_zx02: .incbin \"lake_w_priority.zx02\"" >> priority_intro.inc
	echo "lake_e_priority_zx02: .incbin \"lake_e_priority.zx02\"" >> priority_intro.inc
	echo "river_priority_zx02: .incbin \"river_priority.zx02\"" >> priority_intro.inc
	echo "knight_priority_zx02: .incbin \"knight_priority.zx02\"" >> priority_intro.inc

priority_peasant1.inc:	\
	gary_priority.zx02 top_prints_priority.zx02 \
	wishing_well_priority.zx02 leaning_tree_priority.zx02 \
	waterfall_priority.zx02
	echo "gary_priority_zx02: .incbin \"gary_priority.zx02\"" > priority_peasant1.inc
	echo "top_prints_priority_zx02: .incbin \"top_prints_priority.zx02\"" >> priority_peasant1.inc
	echo "wishing_well_priority_zx02: .incbin \"wishing_well_priority.zx02\"" >> priority_peasant1.inc
	echo "leaning_tree_priority_zx02: .incbin \"leaning_tree_priority.zx02\"" >> priority_peasant1.inc
	echo "waterfall_priority_zx02: .incbin \"waterfall_priority.zx02\"" >> priority_peasant1.inc


###

priority_peasant2.inc:	\
	haystack_priority.zx02 puddle_priority.zx02 \
	archery_priority.zx02 \
	river_priority.zx02 knight_priority.zx02
	echo "haystack_priority_zx02: .incbin \"haystack_priority.zx02\"" > priority_peasant2.inc
	echo "puddle_priority_zx02: .incbin \"puddle_priority.zx02\"" >> priority_peasant2.inc
	echo "archery_priority_zx02: .incbin \"archery_priority.zx02\"" >> priority_peasant2.inc
	echo "river_priority_zx02: .incbin \"river_priority.zx02\"" >> priority_peasant2.inc
	echo "knight_priority_zx02: .incbin \"knight_priority.zx02\"" >> priority_peasant2.inc

###

priority_peasant3.inc:	\
	jhonka_priority.zx02 \
	cottage_priority.zx02 \
	lake_w_priority.zx02 lake_e_priority.zx02 inn_priority.zx02
	echo "jhonka_priority_zx02: .incbin \"jhonka_priority.zx02\"" > priority_peasant3.inc
	echo "cottage_priority_zx02: .incbin \"cottage_priority.zx02\"" >> priority_peasant3.inc
	echo "lake_w_priority_zx02: .incbin \"lake_w_priority.zx02\"" >> priority_peasant3.inc
	echo "lake_e_priority_zx02: .incbin \"lake_e_priority.zx02\"" >> priority_peasant3.inc
	echo "inn_priority_zx02: .incbin \"inn_priority.zx02\"" >> priority_peasant3.inc

###

priority_peasant4.inc:	\
	empty_hut_priority.zx02 \
	ned_priority.zx02 \
	bottom_prints_priority.zx02 \
	lady_cottage_priority.zx02 \
	crooked_tree_priority.zx02
	echo "empty_hut_priority_zx02: .incbin \"empty_hut_priority.zx02\"" > priority_peasant4.inc
	echo "ned_priority_zx02: .incbin \"ned_priority.zx02\"" >> priority_peasant4.inc
	echo "bottom_prints_priority_zx02: .incbin \"bottom_prints_priority.zx02\"" >> priority_peasant4.inc
	echo "lady_cottage_priority_zx02: .incbin \"lady_cottage_priority.zx02\"" >> priority_peasant4.inc
	echo "crooked_tree_priority_zx02: .incbin \"crooked_tree_priority.zx02\"" >> priority_peasant4.inc


###

archery.zx02:	archery.hgr
	$(ZX02) archery.hgr archery.zx02

archery.hgr:	archery.png
	$(PNG2HGR) archery.png > archery.hgr

###

bottom_prints.zx02:	bottom_prints.hgr
	$(ZX02) bottom_prints.hgr bottom_prints.zx02

bottom_prints.hgr:	bottom_prints.png
	$(PNG2HGR) bottom_prints.png > bottom_prints.hgr

###

cottage.zx02:	cottage.hgr
	$(ZX02) cottage.hgr cottage.zx02

cottage.hgr:	cottage.png
	$(PNG2HGR) cottage.png > cottage.hgr

###

crooked_tree.zx02:	crooked_tree.hgr
	$(ZX02) crooked_tree.hgr crooked_tree.zx02

crooked_tree.hgr:	crooked_tree.png
	$(PNG2HGR) crooked_tree.png > crooked_tree.hgr

###

empty_hut.zx02:	empty_hut.hgr
	$(ZX02) empty_hut.hgr empty_hut.zx02

empty_hut.hgr:	empty_hut.png
	$(PNG2HGR) empty_hut.png > empty_hut.hgr


###

gary.zx02:	gary.hgr
	$(ZX02) gary.hgr gary.zx02

gary.hgr:	gary.png
	$(PNG2HGR) gary.png > gary.hgr

###

haystack.zx02:	haystack.hgr
	$(ZX02) haystack.hgr haystack.zx02

haystack.hgr:	haystack.png
	$(PNG2HGR) haystack.png > haystack.hgr

###

jhonka.zx02:	jhonka.hgr
	$(ZX02) jhonka.hgr jhonka.zx02

jhonka.hgr:	jhonka.png
	$(PNG2HGR) jhonka.png > jhonka.hgr

###

knight.zx02:	knight.hgr
	$(ZX02) knight.hgr knight.zx02

knight.hgr:	knight.png
	$(PNG2HGR) knight.png > knight.hgr


###

lady_cottage.zx02:	lady_cottage.hgr
	$(ZX02) lady_cottage.hgr lady_cottage.zx02

lady_cottage.hgr:	lady_cottage.png
	$(PNG2HGR) lady_cottage.png > lady_cottage.hgr


###

lake_e.zx02:	lake_e.hgr
	$(ZX02) lake_e.hgr lake_e.zx02

lake_e.hgr:	lake_e.png
	$(PNG2HGR) lake_e.png > lake_e.hgr


###

lake_e_boat.zx02:	lake_e_boat.hgr
	$(ZX02) lake_e_boat.hgr lake_e_boat.zx02

lake_e_boat.hgr:	lake_e_boat.png
	$(PNG2HGR) lake_e_boat.png > lake_e_boat.hgr


###

lake_w.zx02:	lake_w.hgr
	$(ZX02) lake_w.hgr lake_w.zx02

lake_w.hgr:	lake_w.png
	$(PNG2HGR) lake_w.png > lake_w.hgr


###

leaning_tree.zx02:	leaning_tree.hgr
	$(ZX02) leaning_tree.hgr leaning_tree.zx02

leaning_tree.hgr:	leaning_tree.png
	$(PNG2HGR) leaning_tree.png > leaning_tree.hgr

###

ned.zx02:	ned.hgr
	$(ZX02) ned.hgr ned.zx02

ned.hgr:	ned.png
	$(PNG2HGR) ned.png > ned.hgr

###

puddle.zx02:	puddle.hgr
	$(ZX02) puddle.hgr puddle.zx02

puddle.hgr:	puddle.png
	$(PNG2HGR) puddle.png > puddle.hgr

###

river.zx02:	river.hgr
	$(ZX02) river.hgr river.zx02

river.hgr:	river.png
	$(PNG2HGR) river.png > river.hgr

###

top_prints.zx02:	top_prints.hgr
	$(ZX02) top_prints.hgr top_prints.zx02

top_prints.hgr:	top_prints.png
	$(PNG2HGR) top_prints.png > top_prints.hgr


###

waterfall.zx02:	waterfall.hgr
	$(ZX02) waterfall.hgr waterfall.zx02

waterfall.hgr:	waterfall.png
	$(PNG2HGR) waterfall.png > waterfall.hgr

###

wishing_well.zx02:	wishing_well.hgr
	$(ZX02) wishing_well.hgr wishing_well.zx02

wishing_well.hgr:	wishing_well.png
	$(PNG2HGR) wishing_well.png > wishing_well.hgr

###

inn.zx02:	inn.hgr
	$(ZX02) inn.hgr inn.zx02

inn.hgr:	inn.png
	$(PNG2HGR) inn.png > inn.hgr

###

todo.zx02:	todo.hgr
	$(ZX02) todo.hgr todo.zx02

todo.hgr:	todo.png
	$(PNG2HGR) todo.png > todo.hgr


###########################################
###########################################

###

archery_priority.zx02:	archery_priority.hgr
	$(ZX02) archery_priority.hgr archery_priority.zx02

archery_priority.hgr:	archery_priority.png
	$(PNG2GR) archery_priority.png archery_priority.hgr

###

bottom_prints_priority.zx02:	bottom_prints_priority.hgr
	$(ZX02) bottom_prints_priority.hgr bottom_prints_priority.zx02

bottom_prints_priority.hgr:	bottom_prints_priority.png
	$(PNG2GR) bottom_prints_priority.png bottom_prints_priority.hgr

###

cottage_priority.zx02:	cottage_priority.hgr
	$(ZX02) cottage_priority.hgr cottage_priority.zx02

cottage_priority.hgr:	cottage_priority.png
	$(PNG2GR) cottage_priority.png cottage_priority.hgr

###

crooked_tree_priority.zx02:	crooked_tree_priority.hgr
	$(ZX02) crooked_tree_priority.hgr crooked_tree_priority.zx02

crooked_tree_priority.hgr:	crooked_tree_priority.png
	$(PNG2GR) crooked_tree_priority.png crooked_tree_priority.hgr

###

empty_hut_priority.zx02:	empty_hut_priority.hgr
	$(ZX02) empty_hut_priority.hgr empty_hut_priority.zx02

empty_hut_priority.hgr:	empty_hut_priority.png
	$(PNG2GR) empty_hut_priority.png empty_hut_priority.hgr

###

gary_priority.zx02:	gary_priority.hgr
	$(ZX02) gary_priority.hgr gary_priority.zx02

gary_priority.hgr:	gary_priority.png
	$(PNG2GR) gary_priority.png gary_priority.hgr

###

haystack_priority.zx02:	haystack_priority.hgr
	$(ZX02) haystack_priority.hgr haystack_priority.zx02

haystack_priority.hgr:	haystack_priority.png
	$(PNG2GR) haystack_priority.png haystack_priority.hgr

###

inn_priority.zx02:	inn_priority.hgr
	$(ZX02) inn_priority.hgr inn_priority.zx02

inn_priority.hgr:	inn_priority.png
	$(PNG2GR) inn_priority.png inn_priority.hgr

###

jhonka_priority.zx02:	jhonka_priority.hgr
	$(ZX02) jhonka_priority.hgr jhonka_priority.zx02

jhonka_priority.hgr:	jhonka_priority.png
	$(PNG2GR) jhonka_priority.png jhonka_priority.hgr

###

lady_cottage_priority.zx02:	lady_cottage_priority.hgr
	$(ZX02) lady_cottage_priority.hgr lady_cottage_priority.zx02

lady_cottage_priority.hgr:	lady_cottage_priority.png
	$(PNG2GR) lady_cottage_priority.png lady_cottage_priority.hgr

###

leaning_tree_priority.zx02:	leaning_tree_priority.hgr
	$(ZX02) leaning_tree_priority.hgr leaning_tree_priority.zx02

leaning_tree_priority.hgr:	leaning_tree_priority.png
	$(PNG2GR) leaning_tree_priority.png leaning_tree_priority.hgr

###

ned_priority.zx02:	ned_priority.hgr
	$(ZX02) ned_priority.hgr ned_priority.zx02

ned_priority.hgr:	ned_priority.png
	$(PNG2GR) ned_priority.png ned_priority.hgr

###

puddle_priority.zx02:	puddle_priority.hgr
	$(ZX02) puddle_priority.hgr puddle_priority.zx02

puddle_priority.hgr:	puddle_priority.png
	$(PNG2GR) puddle_priority.png puddle_priority.hgr

###

river_priority.zx02:	river_priority.hgr
	$(ZX02) river_priority.hgr river_priority.zx02

river_priority.hgr:	river_priority.png
	$(PNG2GR) river_priority.png river_priority.hgr

###

knight_priority.zx02:	knight_priority.hgr
	$(ZX02) knight_priority.hgr knight_priority.zx02

knight_priority.hgr:	knight_priority.png
	$(PNG2GR) knight_priority.png knight_priority.hgr

###

lake_e_priority.zx02:	lake_e_priority.hgr
	$(ZX02) lake_e_priority.hgr lake_e_priority.zx02

lake_e_priority.hgr:	lake_e_priority.png
	$(PNG2GR) lake_e_priority.png lake_e_priority.hgr

###

lake_w_priority.zx02:	lake_w_priority.hgr
	$(ZX02) lake_w_priority.hgr lake_w_priority.zx02

lake_w_priority.hgr:	lake_w_priority.png
	$(PNG2GR) lake_w_priority.png lake_w_priority.hgr


####

todo_priority.zx02:	todo_priority.gr
	$(ZX02) todo_priority.gr todo_priority.zx02

todo_priority.gr:	todo_priority.png
	$(PNG2GR) todo_priority.png todo_priority.gr

###

top_prints_priority.zx02:	top_prints_priority.hgr
	$(ZX02) top_prints_priority.hgr top_prints_priority.zx02

top_prints_priority.hgr:	top_prints_priority.png
	$(PNG2GR) top_prints_priority.png top_prints_priority.hgr

####

waterfall_priority.zx02:	waterfall_priority.gr
	$(ZX02) waterfall_priority.gr waterfall_priority.zx02

waterfall_priority.gr:	waterfall_priority.png
	$(PNG2GR) waterfall_priority.png waterfall_priority.gr

####

wishing_well_priority.zx02:	wishing_well_priority.hgr
	$(ZX02) wishing_well_priority.hgr wishing_well_priority.zx02

wishing_well_priority.hgr:	wishing_well_priority.png
	$(PNG2GR) wishing_well_priority.png wishing_well_priority.hgr

###


clean:	
	rm -f *~ graphics_intro.inc \
		graphics_peasant1.inc graphics_peasant2.inc \
		graphics_peasant3.inc graphics_peasant4.inc \
		priority_intro.inc \
		priority_peasant1.inc priority_peasant2.inc \
		priority_peasant3.inc priority_peasant4.inc \
		*.zx02 *.gr *.hgr

