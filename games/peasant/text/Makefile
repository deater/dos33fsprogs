CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text shrink_text \
	peasant1.inc.lookup \
	peasant2.inc.lookup \
	peasant3.inc.lookup \
	peasant4.inc.lookup \
	kerrek.inc.lookup \
	inside.inc.lookup \
	inn.inc.lookup \
	cliff.inc.lookup \
	trogdor.inc.lookup \
	common.inc.lookup \
	inventory.inc.lookup

###

cliff.inc.lookup:	cliff.inc shrink_text
	./shrink_text < cliff.inc > cliff.inc.lookup

common.inc.lookup:	common.inc shrink_text
	./shrink_text < common.inc > common.inc.lookup

inn.inc.lookup:	inn.inc shrink_text
	./shrink_text < inn.inc > inn.inc.lookup

inside.inc.lookup:	inside.inc shrink_text
	./shrink_text < inside.inc > inside.inc.lookup

inventory.inc.lookup:	inventory.inc shrink_text
	./shrink_text < inventory.inc > inventory.inc.lookup

peasant1.inc.lookup:	peasant1.inc shrink_text
	./shrink_text < peasant1.inc > peasant1.inc.lookup

peasant2.inc.lookup:	peasant2.inc shrink_text
	./shrink_text < peasant2.inc > peasant2.inc.lookup

peasant3.inc.lookup:	peasant3.inc shrink_text
	./shrink_text < peasant3.inc > peasant3.inc.lookup

peasant4.inc.lookup:	peasant4.inc shrink_text
	./shrink_text < peasant4.inc > peasant4.inc.lookup

kerrek.inc.lookup:	kerrek.inc shrink_text
	./shrink_text < kerrek.inc > kerrek.inc.lookup

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
