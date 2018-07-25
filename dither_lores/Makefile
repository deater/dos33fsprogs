include ../Makefile.inc

all:	png_to_40x96 katahdin_40_96.inc


katahdin_40_96.inc:	png_to_40x96 katahdin_40_96.png
	./png_to_40x96 asm katahdin_40_96.png katahdin > katahdin_40_96.inc

loadpng.o:	loadpng.c
	$(CC) $(CFLAGS) -c loadpng.c

png_to_40x96:		png_to_40x96.o loadpng.o
	$(CC) $(LFLAGS) -lpng -o png_to_40x96 png_to_40x96.o loadpng.o

png_to_40x96.o:		png_to_40x96.c loadpng.h
	$(CC) $(CFLAGS) -c png_to_40x96.c


install:	
		cp png_to_40x96 $(INSTALL_LOC)

clean:		
		rm -f *~ *.o *.inc png_to_40x96


