include ../Makefile.inc

CFLAGS = -g -Wall -O2

all:	png2gr

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c

png2gr:		png2gr.o loadpng.o
	$(CC) $(LFLAGS) -lpng -o png2gr png2gr.o loadpng.o

png2gr.o:		png2gr.c loadpng.h
	$(CC) $(CFLAGS) -c png2gr.c


install:	
		cp png2gr $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr

