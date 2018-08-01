include ../Makefile.inc

CFLAGS = -g -Wall -O2

all:	png2gr png2rle png_to_40x48d png_to_40x96


###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c


###

png2gr:		png2gr.o loadpng.o
	$(CC) $(LFLAGS) -lpng -o png2gr png2gr.o loadpng.o

png2gr.o:		png2gr.c loadpng.h
	$(CC) $(CFLAGS) -c png2gr.c

###

png2rle:		png2rle.o loadpng.o
	$(CC) $(LFLAGS) -lpng -o png2rle png2rle.o loadpng.o

png2rle.o:		png2rle.c loadpng.h
	$(CC) $(CFLAGS) -c png2rle.c


###

png_to_40x48d:		png_to_40x48d.o
	$(CC) $(LFLAGS) -lpng -o png_to_40x48d png_to_40x48d.o

png_to_40x48d.o:		png_to_40x48d.c
	$(CC) $(CFLAGS) -c png_to_40x48d.c

###

png_to_40x96:		png_to_40x96.o
	$(CC) $(LFLAGS) -lpng -o png_to_40x96 png_to_40x96.o

png_to_40x96.o:		png_to_40x96.c
	$(CC) $(CFLAGS) -c png_to_40x96.c


###

install:	
		cp png2gr png2rle png_to_40x48d png_to_40x96 $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr png2rle png_to_40x48d png_to_40x96

