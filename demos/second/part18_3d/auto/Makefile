CC = gcc
CFLAGS = -g -Wall -O2

all:	box_convert

###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c


###

box_convert:		box_convert.o loadpng.o
	$(CC) $(LFLAGS) -o box_convert box_convert.o loadpng.o -lpng

box_convert.o:		box_convert.c loadpng.h
	$(CC) $(CFLAGS) -c box_convert.c

###

clean:		
		rm -f *~ *.o box_convert

