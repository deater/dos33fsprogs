
include ../Makefile.inc

CFLAGS = -g -Wall -O2

all:	png2gr png2rle


###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c


###

png2gr:		png2gr.o loadpng.o
	$(CC) $(LFLAGS) -o png2gr png2gr.o loadpng.o -lpng

png2gr.o:		png2gr.c loadpng.h
	$(CC) $(CFLAGS) -c png2gr.c

###

png2rle:		png2rle.o loadpng.o
	$(CC) $(LFLAGS) -o png2rle png2rle.o loadpng.o -lpng

png2rle.o:		png2rle.c loadpng.h
	$(CC) $(CFLAGS) -c png2rle.c

###

install:	
		cp png2gr png2rle $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr png2rle

