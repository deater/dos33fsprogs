CC = gcc
CFLAGS = -g -Wall -O2

all:	box_convert make_sizes

###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c


###

box_convert:		box_convert.o loadpng.o
	$(CC) $(LFLAGS) -o box_convert box_convert.o loadpng.o -lpng

box_convert.o:		box_convert.c loadpng.h box_sizes.c
	$(CC) $(CFLAGS) -c box_convert.c

###

make_sizes:		make_sizes.o
	$(CC) $(LFLAGS) -o make_sizes make_sizes.o

make_sizes.o:		make_sizes.c loadpng.h
	$(CC) $(CFLAGS) -c make_sizes.c


###

clean:		
		rm -f *~ *.o box_convert make_sizes

