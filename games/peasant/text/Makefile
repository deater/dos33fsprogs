CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text shrink_text peasant2.inc.lookup

###

peasant2.inc.lookup:	peasant2.inc shrink_text
	./shrink_text < peasant2.inc > peasant2.inc.lookup


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
	rm -f *.o dump_text shrink_text *.lookup



