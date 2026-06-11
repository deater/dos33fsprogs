CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	arrows

arrows:	arrows.o
	$(CC) $(LFLAGS) -o arrows arrows.o $(LFLAGS)

arrows.o:	arrows.c
	$(CC) $(CFLAGS) -c arrows.c


clean:	
	rm -f *.o *~ arrows
