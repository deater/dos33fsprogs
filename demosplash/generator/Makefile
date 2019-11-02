CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	creator offsets

creator:	creator.o
	$(CC) -o creator creator.o $(LFLAGS)

creator.o:	creator.c
	$(CC) $(CFLAGS) -c creator.c

offsets:	offsets.o
	$(CC) -o offsets offsets.o $(LFLAGS)

offsets.o:	offsets.c
	$(CC) $(CFLAGS) -c offsets.c

clean:
	rm -f *.o creator offsets
