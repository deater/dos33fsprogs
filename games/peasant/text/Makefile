include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text shrink_text \
	DIALOG_PEASANT1.ZX02 dialog_peasant1.inc \
	DIALOG_PEASANT2.ZX02 dialog_peasant2.inc \
	DIALOG_PEASANT3.ZX02 dialog_peasant3.inc \
	DIALOG_PEASANT4.ZX02 dialog_peasant4.inc \
	DIALOG_INSIDE.ZX02 dialog_inside.inc \
	DIALOG_INN.ZX02 dialog_inn.inc \
	DIALOG_CLIFF_BASE.ZX02 dialog_cliff_base.inc \
	cliff.inc.lookup \
	DIALOG_TROGDOR.ZX02 dialog_trogdor.inc \
	common.inc.lookup \
	inventory.inc.lookup


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

DIALOG_PEASANT2.ZX02:	dialog_peasant2
	$(ZX02) -f  dialog_peasant2 DIALOG_PEASANT2.ZX02

dialog_peasant2:	dialog_peasant2.o
	ld65 -o dialog_peasant2 dialog_peasant2.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_peasant2.o:	dialog_peasant2.s \
		hay.inc.lookup mud.inc.lookup \
		archery.inc.lookup rock.inc.lookup \
		knight.inc.lookup
	ca65 -o dialog_peasant2.o dialog_peasant2.s -l dialog_peasant2.lst

dialog_peasant2.inc:	../generate_all_symbols dialog_peasant2
	../generate_all_symbols -a 0xd000 dialog_peasant2.lst > dialog_peasant2.inc

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

DIALOG_INN.ZX02:	dialog_inn
	$(ZX02) -f  dialog_inn DIALOG_INN.ZX02

dialog_inn:	dialog_inn.o
	ld65 -o dialog_inn dialog_inn.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

dialog_inn.o:	dialog_inn.s inside_inn.inc.lookup
	ca65 -o dialog_inn.o dialog_inn.s -l dialog_inn.lst

dialog_inn.inc:	../generate_all_symbols dialog_inn
	../generate_all_symbols -a 0xd000 dialog_inn.lst > dialog_inn.inc

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

common.inc.lookup:	common.inc shrink_text
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
