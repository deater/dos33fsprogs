include ../Makefile.inc

CFLAGS = -g -Wall -O2

all:	png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96


###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c

rle_common.o:	rle_common.c rle_common.h
	$(CC) $(CFLAGS) -c rle_common.c

###

png2gr:		png2gr.o loadpng.o
	$(CC) $(LFLAGS) -o png2gr png2gr.o loadpng.o -lpng

png2gr.o:		png2gr.c loadpng.h
	$(CC) $(CFLAGS) -c png2gr.c

###

png2gr_text:		png2gr_text.o loadpng.o
	$(CC) $(LFLAGS) -o png2gr_text png2gr_text.o loadpng.o -lpng

png2gr_text.o:		png2gr_text.c loadpng.h
	$(CC) $(CFLAGS) -c png2gr_text.c

###

png2rle:		png2rle.o loadpng.o rle_common.o
	$(CC) $(LFLAGS) -o png2rle png2rle.o loadpng.o rle_common.o -lpng

png2rle.o:		png2rle.c loadpng.h rle_common.h
	$(CC) $(CFLAGS) -c png2rle.c


###

png2lz4:		png2lz4.o loadpng.o
	$(CC) $(LFLAGS) -o png2lz4 png2lz4.o loadpng.o -llz4 -lpng

png2lz4.o:		png2lz4.c loadpng.h
	$(CC) $(CFLAGS) -c png2lz4.c



###

png_to_40x48d:		png_to_40x48d.o rle_common.o
	$(CC) $(LFLAGS) -o png_to_40x48d png_to_40x48d.o rle_common.o -lpng

png_to_40x48d.o:		png_to_40x48d.c rle_common.h
	$(CC) $(CFLAGS) -c png_to_40x48d.c

###

png_to_40x96:		png_to_40x96.o loadpng.o rle_common.o
	$(CC) $(LFLAGS) -o png_to_40x96 png_to_40x96.o loadpng.o rle_common.o -lpng

png_to_40x96.o:		png_to_40x96.c loadpng.h rle_common.h
	$(CC) $(CFLAGS) -c png_to_40x96.c


###

install:	
		cp png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96 $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96

