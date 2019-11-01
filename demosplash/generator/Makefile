CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	creator

creator:	creator.o
	$(CC) -o creator creator.o $(LFLAGS)

creator.o:	creator.c
	$(CC) $(CFLAGS) -c creator.c

clean:
	rm -f *.o creator
