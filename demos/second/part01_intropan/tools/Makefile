CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	make_scroll_tables

make_scroll_tables:	make_scroll_tables.o
	$(CC) $(LFLAGS) -o make_scroll_tables make_scroll_tables.o

make_scroll_tables.o:	make_scroll_tables.c
	$(CC) $(CFLAGS) -c make_scroll_tables.c

clean:	
	rm -f make_scroll_tables *.o *~


