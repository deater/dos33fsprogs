CC = gcc
CFLAGS = -g -Wall -O2

LZSA = ~/research/lzsa/lzsa/lzsa

all:	level1_map.lzsa png2map

level1_map.inc:	level1_map.png png2map
	./png2map level1_map.png level1_map.inc

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

%.lzsa: %.inc
	$(LZSA) -r -f2 $< $@

clean:		
		rm -f *~ *.o *.inc png2map
