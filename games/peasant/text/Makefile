include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text shrink_text \
	DIALOG_PEASANT1.ZX02 dialog_peasant1.inc \
	DIALOG_JHONKA.ZX02 dialog_jhonka.inc \
	DIALOG_COTTAGE.ZX02 dialog_cottage.inc \
	DIALOG_LAKE_WEST.ZX02 dialog_lake_west.inc \
	DIALOG_LAKE_EAST.ZX02 dialog_lake_east.inc \
	DIALOG_OUTSIDE_INN.ZX02 dialog_outside_inn.inc \
	DIALOG_GARY.ZX02 dialog_gary.inc \
	DIALOG_KERREK1.ZX02 dialog_kerrek1.inc \
	DIALOG_WELL.ZX02 dialog_well.inc \
	DIALOG_YELLOW_TREE.ZX02 dialog_yellow_tree.inc \
	DIALOG_WATERFALL.ZX02 dialog_waterfall.inc \
	DIALOG_PUDDLE.ZX02 dialog_puddle.inc \
	DIALOG_HAYSTACK.ZX02 dialog_haystack.inc \
	DIALOG_BROTHERS.ZX02 dialog_brothers.inc \
	DIALOG_RIVER.ZX02 dialog_river.inc \
	DIALOG_KNIGHT.ZX02 dialog_knight.inc \
	DIALOG_PEASANT3.ZX02 dialog_peasant3.inc \
	DIALOG_E_LAKE.ZX02 dialog_e_lake.inc \
	DIALOG_PEASANT4.ZX02 dialog_peasant4.inc \
	DIALOG_INSIDE.ZX02 dialog_inside.inc \
	DIALOG_INSIDE_INN.ZX02 dialog_inside_inn.inc \
	DIALOG_CLIFF_BASE.ZX02 dialog_cliff_base.inc \
	DIALOG_CLIFF_HEIGHTS.ZX02 dialog_cliff_heights.inc \
	DIALOG_OUTER.ZX02 dialog_outer.inc \
	DIALOG_TROGDOR.ZX02 dialog_trogdor.inc \
	DIALOG_CLIMB.ZX02 dialog_climb.inc \
	common.inc.lookup \
	inventory.inc.lookup


###

DIALOG_JHONKA.ZX02:	dialog_jhonka
	$(ZX02) -f  dialog_jhonka DIALOG_JHONKA.ZX02

dialog_jhonka:	dialog_jhonka.o
	ld65 -o dialog_jhonka dialog_jhonka.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_jhonka.o:	dialog_jhonka.s \
		jhonka.inc.lookup
	ca65 -o dialog_jhonka.o dialog_jhonka.s -l dialog_jhonka.lst

dialog_jhonka.inc:	../generate_all_symbols dialog_jhonka
	../generate_all_symbols -a 0xd000 dialog_jhonka.lst > dialog_jhonka.inc

###

DIALOG_COTTAGE.ZX02:	dialog_cottage
	$(ZX02) -f  dialog_cottage DIALOG_COTTAGE.ZX02

dialog_cottage:	dialog_cottage.o
	ld65 -o dialog_cottage dialog_cottage.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_cottage.o:	dialog_cottage.s \
		cottage.inc.lookup
	ca65 -o dialog_cottage.o dialog_cottage.s -l dialog_cottage.lst

dialog_cottage.inc:	../generate_all_symbols dialog_cottage
	../generate_all_symbols -a 0xd000 dialog_cottage.lst > dialog_cottage.inc
###

DIALOG_LAKE_WEST.ZX02:	dialog_lake_west
	$(ZX02) -f  dialog_lake_west DIALOG_LAKE_WEST.ZX02

dialog_lake_west:	dialog_lake_west.o
	ld65 -o dialog_lake_west dialog_lake_west.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_lake_west.o:	dialog_lake_west.s \
		lake_west.inc.lookup
	ca65 -o dialog_lake_west.o dialog_lake_west.s -l dialog_lake_west.lst

dialog_lake_west.inc:	../generate_all_symbols dialog_lake_west
	../generate_all_symbols -a 0xd000 dialog_lake_west.lst > dialog_lake_west.inc
###

DIALOG_LAKE_EAST.ZX02:	dialog_lake_east
	$(ZX02) -f  dialog_lake_east DIALOG_LAKE_EAST.ZX02

dialog_lake_east:	dialog_lake_east.o
	ld65 -o dialog_lake_east dialog_lake_east.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_lake_east.o:	dialog_lake_east.s \
		lake_east.inc.lookup
	ca65 -o dialog_lake_east.o dialog_lake_east.s -l dialog_lake_east.lst

dialog_lake_east.inc:	../generate_all_symbols dialog_lake_east
	../generate_all_symbols -a 0xd000 dialog_lake_east.lst > dialog_lake_east.inc
###

DIALOG_OUTSIDE_INN.ZX02:	dialog_outside_inn
	$(ZX02) -f  dialog_outside_inn DIALOG_OUTSIDE_INN.ZX02

dialog_outside_inn:	dialog_outside_inn.o
	ld65 -o dialog_outside_inn dialog_outside_inn.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_outside_inn.o:	dialog_outside_inn.s \
		outside_inn.inc.lookup
	ca65 -o dialog_outside_inn.o dialog_outside_inn.s -l dialog_outside_inn.lst

dialog_outside_inn.inc:	../generate_all_symbols dialog_outside_inn
	../generate_all_symbols -a 0xd000 dialog_outside_inn.lst > dialog_outside_inn.inc

###

DIALOG_GARY.ZX02:	dialog_gary
	$(ZX02) -f  dialog_gary DIALOG_GARY.ZX02

dialog_gary:	dialog_gary.o
	ld65 -o dialog_gary dialog_gary.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_gary.o:	dialog_gary.s \
		gary.inc.lookup
	ca65 -o dialog_gary.o dialog_gary.s -l dialog_gary.lst

dialog_gary.inc:	../generate_all_symbols dialog_gary
	../generate_all_symbols -a 0xd000 dialog_gary.lst > dialog_gary.inc

###

DIALOG_KERREK1.ZX02:	dialog_kerrek1
	$(ZX02) -f  dialog_kerrek1 DIALOG_KERREK1.ZX02

dialog_kerrek1:	dialog_kerrek1.o
	ld65 -o dialog_kerrek1 dialog_kerrek1.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_kerrek1.o:	dialog_kerrek1.s \
		kerrek.inc.lookup
	ca65 -o dialog_kerrek1.o dialog_kerrek1.s -l dialog_kerrek1.lst

dialog_kerrek1.inc:	../generate_all_symbols dialog_kerrek1
	../generate_all_symbols -a 0xd000 dialog_kerrek1.lst > dialog_kerrek1.inc

###

DIALOG_WELL.ZX02:	dialog_well
	$(ZX02) -f  dialog_well DIALOG_WELL.ZX02

dialog_well:	dialog_well.o
	ld65 -o dialog_well dialog_well.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_well.o:	dialog_well.s \
		well.inc.lookup
	ca65 -o dialog_well.o dialog_well.s -l dialog_well.lst

dialog_well.inc:	../generate_all_symbols dialog_well
	../generate_all_symbols -a 0xd000 dialog_well.lst > dialog_well.inc

###

DIALOG_YELLOW_TREE.ZX02:	dialog_yellow_tree
	$(ZX02) -f  dialog_yellow_tree DIALOG_YELLOW_TREE.ZX02

dialog_yellow_tree:	dialog_yellow_tree.o
	ld65 -o dialog_yellow_tree dialog_yellow_tree.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_yellow_tree.o:	dialog_yellow_tree.s \
		yellow_tree.inc.lookup
	ca65 -o dialog_yellow_tree.o dialog_yellow_tree.s -l dialog_yellow_tree.lst

dialog_yellow_tree.inc:	../generate_all_symbols dialog_yellow_tree
	../generate_all_symbols -a 0xd000 dialog_yellow_tree.lst > dialog_yellow_tree.inc

###

DIALOG_WATERFALL.ZX02:	dialog_waterfall
	$(ZX02) -f  dialog_waterfall DIALOG_WATERFALL.ZX02

dialog_waterfall:	dialog_waterfall.o
	ld65 -o dialog_waterfall dialog_waterfall.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_waterfall.o:	dialog_waterfall.s \
		falls.inc.lookup
	ca65 -o dialog_waterfall.o dialog_waterfall.s -l dialog_waterfall.lst

dialog_waterfall.inc:	../generate_all_symbols dialog_waterfall
	../generate_all_symbols -a 0xd000 dialog_waterfall.lst > dialog_waterfall.inc


###

DIALOG_CLIFF_BASE.ZX02:	dialog_cliff_base
	$(ZX02) -f  dialog_cliff_base DIALOG_CLIFF_BASE.ZX02

dialog_cliff_base:	dialog_cliff_base.o
	ld65 -o dialog_cliff_base dialog_cliff_base.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_cliff_base.o:	dialog_cliff_base.s \
		cliff_base.inc.lookup
	ca65 -o dialog_cliff_base.o dialog_cliff_base.s -l dialog_cliff_base.lst

dialog_cliff_base.inc:	../generate_all_symbols dialog_cliff_base
	../generate_all_symbols -a 0xd000 dialog_cliff_base.lst > dialog_cliff_base.inc

###

DIALOG_E_LAKE.ZX02:	dialog_e_lake
	$(ZX02) -f  dialog_e_lake DIALOG_E_LAKE.ZX02

dialog_e_lake:	dialog_e_lake.o
	ld65 -o dialog_e_lake dialog_e_lake.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_e_lake.o:	dialog_e_lake.s \
		lake_east.inc.lookup
	ca65 -o dialog_e_lake.o dialog_e_lake.s -l dialog_e_lake.lst

dialog_e_lake.inc:	../generate_all_symbols dialog_e_lake
	../generate_all_symbols -a 0xd000 dialog_e_lake.lst > dialog_e_lake.inc


###

DIALOG_KNIGHT.ZX02:	dialog_knight
	$(ZX02) -f  dialog_knight DIALOG_KNIGHT.ZX02

dialog_knight:	dialog_knight.o
	ld65 -o dialog_knight dialog_knight.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_knight.o:	dialog_knight.s \
		knight.inc.lookup
	ca65 -o dialog_knight.o dialog_knight.s -l dialog_knight.lst

dialog_knight.inc:	../generate_all_symbols dialog_knight
	../generate_all_symbols -a 0xd000 dialog_knight.lst > dialog_knight.inc

###

DIALOG_RIVER.ZX02:	dialog_river
	$(ZX02) -f  dialog_river DIALOG_RIVER.ZX02

dialog_river:	dialog_river.o
	ld65 -o dialog_river dialog_river.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_river.o:	dialog_river.s \
		rock.inc.lookup
	ca65 -o dialog_river.o dialog_river.s -l dialog_river.lst

dialog_river.inc:	../generate_all_symbols dialog_river
	../generate_all_symbols -a 0xd000 dialog_river.lst > dialog_river.inc

###

DIALOG_BROTHERS.ZX02:	dialog_brothers
	$(ZX02) -f  dialog_brothers DIALOG_BROTHERS.ZX02

dialog_brothers:	dialog_brothers.o
	ld65 -o dialog_brothers dialog_brothers.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_brothers.o:	dialog_brothers.s \
		archery.inc.lookup
	ca65 -o dialog_brothers.o dialog_brothers.s -l dialog_brothers.lst

dialog_brothers.inc:	../generate_all_symbols dialog_brothers
	../generate_all_symbols -a 0xd000 dialog_brothers.lst > dialog_brothers.inc

###

DIALOG_PUDDLE.ZX02:	dialog_puddle
	$(ZX02) -f  dialog_puddle DIALOG_PUDDLE.ZX02

dialog_puddle:	dialog_puddle.o
	ld65 -o dialog_puddle dialog_puddle.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_puddle.o:	dialog_puddle.s \
		mud.inc.lookup
	ca65 -o dialog_puddle.o dialog_puddle.s -l dialog_puddle.lst

dialog_puddle.inc:	../generate_all_symbols dialog_puddle
	../generate_all_symbols -a 0xd000 dialog_puddle.lst > dialog_puddle.inc

###

DIALOG_HAYSTACK.ZX02:	dialog_haystack
	$(ZX02) -f  dialog_haystack DIALOG_HAYSTACK.ZX02

dialog_haystack:	dialog_haystack.o
	ld65 -o dialog_haystack dialog_haystack.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_haystack.o:	dialog_haystack.s \
		hay.inc.lookup
	ca65 -o dialog_haystack.o dialog_haystack.s -l dialog_haystack.lst

dialog_haystack.inc:	../generate_all_symbols dialog_haystack
	../generate_all_symbols -a 0xd000 dialog_haystack.lst > dialog_haystack.inc





###


DIALOG_CLIMB.ZX02:	dialog_climb
	$(ZX02) -f  dialog_climb DIALOG_CLIMB.ZX02

dialog_climb:	dialog_climb.o
	ld65 -o dialog_climb dialog_climb.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_climb.o:	dialog_climb.s \
		climb.inc.lookup
	ca65 -o dialog_climb.o dialog_climb.s -l dialog_climb.lst

dialog_climb.inc:	../generate_all_symbols dialog_climb
	../generate_all_symbols -a 0xd000 dialog_climb.lst > dialog_climb.inc



###

DIALOG_CLIFF_HEIGHTS.ZX02:	dialog_cliff_heights
	$(ZX02) -f  dialog_cliff_heights DIALOG_CLIFF_HEIGHTS.ZX02

dialog_cliff_heights:	dialog_cliff_heights.o
	ld65 -o dialog_cliff_heights dialog_cliff_heights.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_cliff_heights.o:	dialog_cliff_heights.s \
		cliff_heights.inc.lookup
	ca65 -o dialog_cliff_heights.o dialog_cliff_heights.s -l dialog_cliff_heights.lst

dialog_cliff_heights.inc:	../generate_all_symbols dialog_cliff_heights
	../generate_all_symbols -a 0xd000 dialog_cliff_heights.lst > dialog_cliff_heights.inc

###

DIALOG_OUTER.ZX02:	dialog_outer
	$(ZX02) -f  dialog_outer DIALOG_OUTER.ZX02

dialog_outer:	dialog_outer.o
	ld65 -o dialog_outer dialog_outer.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_outer.o:	dialog_outer.s \
		outer.inc.lookup
	ca65 -o dialog_outer.o dialog_outer.s -l dialog_outer.lst

dialog_outer.inc:	../generate_all_symbols dialog_outer
	../generate_all_symbols -a 0xd000 dialog_outer.lst > dialog_outer.inc





###

DIALOG_PEASANT1.ZX02:	dialog_peasant1
	$(ZX02) -f  dialog_peasant1 DIALOG_PEASANT1.ZX02

dialog_peasant1:	dialog_peasant1.o
	ld65 -o dialog_peasant1 dialog_peasant1.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_peasant1.o:	dialog_peasant1.s \
		gary.inc.lookup kerrek.inc.lookup \
		well.inc.lookup yellow_tree.inc.lookup \
		falls.inc.lookup
	ca65 -o dialog_peasant1.o dialog_peasant1.s -l dialog_peasant1.lst

dialog_peasant1.inc:	../generate_all_symbols dialog_peasant1
	../generate_all_symbols -a 0xd000 dialog_peasant1.lst > dialog_peasant1.inc

###

#DIALOG_PEASANT2.ZX02:	dialog_peasant2
#	$(ZX02) -f  dialog_peasant2 DIALOG_PEASANT2.ZX02

#dialog_peasant2:	dialog_peasant2.o
#	ld65 -o dialog_peasant2 dialog_peasant2.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

#dialog_peasant2.o:	dialog_peasant2.s \
#		hay.inc.lookup mud.inc.lookup \
#		archery.inc.lookup rock.inc.lookup \
#		knight.inc.lookup
#	ca65 -o dialog_peasant2.o dialog_peasant2.s -l dialog_peasant2.lst

#dialog_peasant2.inc:	../generate_all_symbols dialog_peasant2
#	../generate_all_symbols -a 0xd000 dialog_peasant2.lst > dialog_peasant2.inc

###

DIALOG_PEASANT3.ZX02:	dialog_peasant3
	$(ZX02) -f  dialog_peasant3 DIALOG_PEASANT3.ZX02

dialog_peasant3:	dialog_peasant3.o
	ld65 -o dialog_peasant3 dialog_peasant3.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_peasant3.o:	dialog_peasant3.s \
		jhonka.inc.lookup cottage.inc.lookup \
		lake_west.inc.lookup lake_east.inc.lookup \
		outside_inn.inc.lookup
	ca65 -o dialog_peasant3.o dialog_peasant3.s -l dialog_peasant3.lst

dialog_peasant3.inc:	../generate_all_symbols dialog_peasant3
	../generate_all_symbols -a 0xd000 dialog_peasant3.lst > dialog_peasant3.inc

###

DIALOG_PEASANT4.ZX02:	dialog_peasant4
	$(ZX02) -f  dialog_peasant4 DIALOG_PEASANT4.ZX02

dialog_peasant4:	dialog_peasant4.o
	ld65 -o dialog_peasant4 dialog_peasant4.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_peasant4.o:	dialog_peasant4.s \
		ned_cottage.inc.lookup wavy_tree.inc.lookup \
		kerrek.inc.lookup lady_cottage.inc.lookup \
		burninated_tree.inc.lookup
	ca65 -o dialog_peasant4.o dialog_peasant4.s -l dialog_peasant4.lst

dialog_peasant4.inc:	../generate_all_symbols dialog_peasant4
	../generate_all_symbols -a 0xd000 dialog_peasant4.lst > dialog_peasant4.inc

###

DIALOG_INSIDE_INN.ZX02:	dialog_inside_inn
	$(ZX02) -f  dialog_inside_inn DIALOG_INSIDE_INN.ZX02

dialog_inside_inn:	dialog_inside_inn.o
	ld65 -o dialog_inside_inn dialog_inside_inn.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_inside_inn.o:	dialog_inside_inn.s inside_inn.inc.lookup
	ca65 -o dialog_inside_inn.o dialog_inside_inn.s -l dialog_inside_inn.lst

dialog_inside_inn.inc:	../generate_all_symbols dialog_inside_inn
	../generate_all_symbols -a 0xd000 dialog_inside_inn.lst > dialog_inside_inn.inc


###

DIALOG_INSIDE.ZX02:	dialog_inside
	$(ZX02) -f  dialog_inside DIALOG_INSIDE.ZX02

dialog_inside:	dialog_inside.o
	ld65 -o dialog_inside dialog_inside.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_inside.o:	dialog_inside.s \
		inside_lady.inc.lookup inside_ned.inc.lookup \
		hidden_glen.inc.lookup
	ca65 -o dialog_inside.o dialog_inside.s -l dialog_inside.lst

dialog_inside.inc:	../generate_all_symbols dialog_inside
	../generate_all_symbols -a 0xd000 dialog_inside.lst > dialog_inside.inc

###

DIALOG_TROGDOR.ZX02:	dialog_trogdor
	$(ZX02) -f  dialog_trogdor DIALOG_TROGDOR.ZX02

dialog_trogdor:	dialog_trogdor.o
	ld65 -o dialog_trogdor dialog_trogdor.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_trogdor.o:	dialog_trogdor.s \
		trogdor.inc.lookup
	ca65 -o dialog_trogdor.o dialog_trogdor.s -l dialog_trogdor.lst

dialog_trogdor.inc:	../generate_all_symbols dialog_trogdor
	../generate_all_symbols -a 0xd000 dialog_trogdor.lst > dialog_trogdor.inc




###


####################
# single locations #
####################

archery.inc.lookup:	archery.inc shrink_text
	./shrink_text < archery.inc > archery.inc.lookup

burninated_tree.inc.lookup:	burninated_tree.inc shrink_text
	./shrink_text < burninated_tree.inc > burninated_tree.inc.lookup

cliff_base.inc.lookup:	cliff_base.inc shrink_text
	./shrink_text < cliff_base.inc > cliff_base.inc.lookup

cliff_heights.inc.lookup:	cliff_heights.inc shrink_text
	./shrink_text < cliff_heights.inc > cliff_heights.inc.lookup

climb.inc.lookup:	climb.inc shrink_text
	./shrink_text < climb.inc > climb.inc.lookup

cottage.inc.lookup:	cottage.inc shrink_text
	./shrink_text < cottage.inc > cottage.inc.lookup

falls.inc.lookup:	falls.inc shrink_text
	./shrink_text < falls.inc > falls.inc.lookup

gary.inc.lookup:	gary.inc shrink_text
	./shrink_text < gary.inc > gary.inc.lookup

hay.inc.lookup:	hay.inc shrink_text
	./shrink_text < hay.inc > hay.inc.lookup

hidden_glen.inc.lookup:	hidden_glen.inc shrink_text
	./shrink_text < hidden_glen.inc > hidden_glen.inc.lookup

inside_inn.inc.lookup:	inside_inn.inc shrink_text
	./shrink_text < inside_inn.inc > inside_inn.inc.lookup

inside_lady.inc.lookup:	inside_lady.inc shrink_text
	./shrink_text < inside_lady.inc > inside_lady.inc.lookup

inside_ned.inc.lookup:	inside_ned.inc shrink_text
	./shrink_text < inside_ned.inc > inside_ned.inc.lookup

jhonka.inc.lookup:	jhonka.inc shrink_text
	./shrink_text < jhonka.inc > jhonka.inc.lookup

kerrek.inc.lookup:	kerrek.inc shrink_text
	./shrink_text < kerrek.inc > kerrek.inc.lookup

knight.inc.lookup:	knight.inc shrink_text
	./shrink_text < knight.inc > knight.inc.lookup

lady_cottage.inc.lookup:	lady_cottage.inc shrink_text
	./shrink_text < lady_cottage.inc > lady_cottage.inc.lookup

lake_east.inc.lookup:	lake_east.inc shrink_text
	./shrink_text < lake_east.inc > lake_east.inc.lookup

lake_west.inc.lookup:	lake_west.inc shrink_text
	./shrink_text < lake_west.inc > lake_west.inc.lookup

mud.inc.lookup:	mud.inc shrink_text
	./shrink_text < mud.inc > mud.inc.lookup

ned_cottage.inc.lookup:	ned_cottage.inc shrink_text
	./shrink_text < ned_cottage.inc > ned_cottage.inc.lookup

outer.inc.lookup:	outer.inc shrink_text
	./shrink_text < outer.inc > outer.inc.lookup

outside_inn.inc.lookup:	outside_inn.inc shrink_text
	./shrink_text < outside_inn.inc > outside_inn.inc.lookup

rock.inc.lookup:	rock.inc shrink_text
	./shrink_text < rock.inc > rock.inc.lookup

wavy_tree.inc.lookup:	wavy_tree.inc shrink_text
	./shrink_text < wavy_tree.inc > wavy_tree.inc.lookup

well.inc.lookup:	well.inc shrink_text
	./shrink_text < well.inc > well.inc.lookup

yellow_tree.inc.lookup:	yellow_tree.inc shrink_text
	./shrink_text < yellow_tree.inc > yellow_tree.inc.lookup




###

cliff.inc.lookup:	cliff.inc shrink_text
	./shrink_text < cliff.inc > cliff.inc.lookup

common.inc.lookup:	common.inc ../version.inc shrink_text
	./shrink_text < common.inc > common.inc.lookup


inside.inc.lookup:	inside.inc shrink_text
	./shrink_text < inside.inc > inside.inc.lookup

inventory.inc.lookup:	inventory.inc shrink_text
	./shrink_text < inventory.inc > inventory.inc.lookup





trogdor.inc.lookup:	trogdor.inc shrink_text
	./shrink_text < trogdor.inc > trogdor.inc.lookup

###

dump_text:	dump_text.o
	$(CC) -o dump_text dump_text.o $(LFLAGS)

dump_text.o:	dump_text.c
	$(CC) $(CFLAGS) -c dump_text.c

###

shrink_text:	shrink_text.o
	$(CC) -o shrink_text shrink_text.o $(LFLAGS)

shrink_text.o:	shrink_text.c
	$(CC) $(CFLAGS) -c shrink_text.c

###

clean:	
	rm -f *.o *~ dump_text shrink_text *.lookup *.ZX02

distclean:	
	rm -f *.o *~ dump_text shrink_text *.lookup *.ZX02
