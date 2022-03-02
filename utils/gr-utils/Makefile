include ../../Makefile.inc

CFLAGS = -g -Wall -O2

all:	text2gr png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96 \
	png2sixbitmap png2six80 png2sixrle png2fourrle png2sixrle2 png_16x16 \
	png2raw

###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c

rle_common.o:	rle_common.c rle_common.h
	$(CC) $(CFLAGS) -c rle_common.c
###

text2gr:	text2gr.o
	$(CC) $(LFLAGS) -o text2gr text2gr.o

text2gr.o:		text2gr.c
	$(CC) $(CFLAGS) -c text2gr.c

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

png2sixbitmap:		png2sixbitmap.o loadpng.o
	$(CC) $(LFLAGS) -o png2sixbitmap png2sixbitmap.o loadpng.o -lpng

png2sixbitmap.o:		png2sixbitmap.c loadpng.h
	$(CC) $(CFLAGS) -c png2sixbitmap.c

###

png_16x16:		png_16x16.o loadpng.o
	$(CC) $(LFLAGS) -o png_16x16 png_16x16.o loadpng.o -lpng

png_16x16.o:		png_16x16.c loadpng.h
	$(CC) $(CFLAGS) -c png_16x16.c

###

png2fourrle:		png2fourrle.o loadpng.o
	$(CC) $(LFLAGS) -o png2fourrle png2fourrle.o loadpng.o -lpng

png2fourrle.o:		png2fourrle.c loadpng.h
	$(CC) $(CFLAGS) -c png2fourrle.c

###

png2sixrle:		png2sixrle.o loadpng.o
	$(CC) $(LFLAGS) -o png2sixrle png2sixrle.o loadpng.o -lpng

png2sixrle.o:		png2sixrle.c loadpng.h
	$(CC) $(CFLAGS) -c png2sixrle.c

###

png2sixrle2:		png2sixrle2.o loadpng.o
	$(CC) $(LFLAGS) -o png2sixrle2 png2sixrle2.o loadpng.o -lpng

png2sixrle2.o:		png2sixrle2.c loadpng.h
	$(CC) $(CFLAGS) -c png2sixrle2.c



###

png2six80:		png2six80.o loadpng.o
	$(CC) $(LFLAGS) -o png2six80 png2six80.o loadpng.o -lpng

png2six80.o:		png2six80.c loadpng.h
	$(CC) $(CFLAGS) -c png2six80.c


###

png2rle:		png2rle.o loadpng.o rle_common.o
	$(CC) $(LFLAGS) -o png2rle png2rle.o loadpng.o rle_common.o -lpng

png2rle.o:		png2rle.c loadpng.h rle_common.h
	$(CC) $(CFLAGS) -c png2rle.c

###

png2raw:		png2raw.o loadpng.o
	$(CC) $(LFLAGS) -o png2raw png2raw.o loadpng.o -lpng

png2raw.o:		png2raw.c loadpng.h
	$(CC) $(CFLAGS) -c png2raw.c



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
		cp png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96 png2sixbitmap png2sixrle png2sixrle2 png2fourrle png2six80 png_16x16 png2raw $(INSTALL_LOC)

clean:		
		rm -f *~ *.o png2gr png2gr_text png2rle png2lz4 png_to_40x48d png_to_40x96 png2sixbitmap png2sixrle png2fourrle png2sixrle2 png2six80 text2gr pnglarge2rle png_16x16 png2raw

