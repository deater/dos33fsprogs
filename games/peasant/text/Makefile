CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text shrink_text \
	peasant1.inc \
	peasant2.inc \
	peasant3.inc \
	peasant4.inc \
	inside.inc.lookup \
	inn.inc.lookup \
	cliff_base.inc.lookup \
	cliff.inc.lookup \
	trogdor.inc.lookup \
	common.inc.lookup \
	inventory.inc.lookup

#####################
# derived locations #
#####################

peasant1.inc:	gary.inc.lookup kerrek.inc.lookup \
		well.inc.lookup yellow_tree.inc.lookup \
		falls.inc.lookup


peasant2.inc:	hay.inc.lookup mud.inc.lookup \
		archery.inc.lookup rock.inc.lookup \
		knight.inc.lookup


peasant3.inc:	jhonka.inc.lookup cottage.inc.lookup \
		lake_west.inc.lookup lake_east.inc.lookup \
		outside_inn.inc.lookup

peasant4.inc:	ned_cottage.inc.lookup wavy_tree.inc.lookup \
		kerrek.inc.lookup lady_cottage.inc.lookup \
		burninated_tree.inc.lookup


####################
# single locations #
####################

archery.inc.lookup:	archery.inc shrink_text
	./shrink_text < archery.inc > archery.inc.lookup

burninated_tree.inc.lookup:	burninated_tree.inc shrink_text
	./shrink_text < burninated_tree.inc > burninated_tree.inc.lookup

cottage.inc.lookup:	cottage.inc shrink_text
	./shrink_text < cottage.inc > cottage.inc.lookup

falls.inc.lookup:	falls.inc shrink_text
	./shrink_text < falls.inc > falls.inc.lookup

gary.inc.lookup:	gary.inc shrink_text
	./shrink_text < gary.inc > gary.inc.lookup

hay.inc.lookup:	hay.inc shrink_text
	./shrink_text < hay.inc > hay.inc.lookup

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

cliff_base.inc.lookup:	cliff_base.inc shrink_text
	./shrink_text < cliff_base.inc > cliff_base.inc.lookup

common.inc.lookup:	common.inc shrink_text
	./shrink_text < common.inc > common.inc.lookup

inn.inc.lookup:	inn.inc shrink_text
	./shrink_text < inn.inc > inn.inc.lookup

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
	rm -f *.o *~ dump_text shrink_text *.lookup
