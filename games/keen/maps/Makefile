CC = gcc
CFLAGS = -g -Wall -O2

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../utils/gr-utils/png2gr


all:	level1_map.zx02 png2map mars_map.gr.zx02

###

level1_map.zx02:	level1_map.inc
	$(ZX02) level1_map.inc level1_map.zx02

level1_map.inc:	level1_map.png png2map
	./png2map level1_map.png level1_map.inc


###

mars_map.gr.zx02:	mars_map.gr
	$(ZX02) mars_map.gr mars_map.gr.zx02

mars_map.gr:	mars_map.png
	$(PNG2GR) mars_map.png mars_map.gr



###

loadpng.o:	loadpng.c loadpng.h
	$(CC) $(CFLAGS) -c loadpng.c

rle_common.o:	rle_common.c rle_common.h
	$(CC) $(CFLAGS) -c rle_common.c
###

png2map:		png2map.o loadpng.o
	$(CC) $(LFLAGS) -o png2map png2map.o loadpng.o -lpng

png2map.o:		png2map.c loadpng.h
	$(CC) $(CFLAGS) -c png2map.c

###

clean:		
		rm -f *~ *.o *.inc png2map
