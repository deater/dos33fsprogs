CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	creator offsets offsets2

creator:	creator.o
	$(CC) -o creator creator.o $(LFLAGS)

creator.o:	creator.c
	$(CC) $(CFLAGS) -c creator.c

offsets:	offsets.o
	$(CC) -o offsets offsets.o $(LFLAGS)

offsets.o:	offsets.c
	$(CC) $(CFLAGS) -c offsets.c

offsets2:	offsets2.o
	$(CC) -o offsets2 offsets2.o $(LFLAGS)

offsets2.o:	offsets2.c
	$(CC) $(CFLAGS) -c offsets2.c

clean:
	rm -f *.o creator offsets offsets2
