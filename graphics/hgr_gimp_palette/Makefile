CC = gcc
CFLAGS = -O2 -Wall -g
LFLAGS = -lm

all:	make_pal

make_pal:	make_pal.o
	$(CC) -o make_pal make_pal.o $(LFLAGS)

make_pal.o:	make_pal.c
	$(CC) $(CFLAGS) -c make_pal.c

clean:	
	rm -f *~ *.o make_pal

