CC = gcc
CFLAGS = -g -Wall -O2

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../utils/gr-utils/png2gr


all:	png2map \
	level1_map.zx02 level2_map.zx02 \
	level3_map.zx02 level4_map.zx02 \
	level5_map.zx02 level6_map.zx02 \
	level7_map.zx02 level8_map.zx02 \
	level9_map.zx02 level10_map.zx02 \
	level11_map.zx02 level12_map.zx02 \
	level13_map.zx02 level14_map.zx02 \
	level15_map.zx02 level16_map.zx02 \
	mars_map.zx02

###

level1_map.zx02:	level1_map.inc
	$(ZX02) level1_map.inc level1_map.zx02

level1_map.inc:	level1_map.png png2map
	./png2map level1_map.png level1_map.inc

###

level2_map.zx02:	level2_map.inc
	$(ZX02) level2_map.inc level2_map.zx02

level2_map.inc:	level2_map.png png2map
	./png2map level2_map.png level2_map.inc

###

level3_map.zx02:	level3_map.inc
	$(ZX02) level3_map.inc level3_map.zx02

level3_map.inc:	level3_map.png png2map
	./png2map level3_map.png level3_map.inc

###

level4_map.zx02:	level4_map.inc
	$(ZX02) level4_map.inc level4_map.zx02

level4_map.inc:	level4_map.png png2map
	./png2map level4_map.png level4_map.inc

###

level5_map.zx02:	level5_map.inc
	$(ZX02) level5_map.inc level5_map.zx02

level5_map.inc:	level5_map.png png2map
	./png2map level5_map.png level5_map.inc

###

level6_map.zx02:	level6_map.inc
	$(ZX02) level6_map.inc level6_map.zx02

level6_map.inc:	level6_map.png png2map
	./png2map level6_map.png level6_map.inc

###

level7_map.zx02:	level7_map.inc
	$(ZX02) level7_map.inc level7_map.zx02

level7_map.inc:	level7_map.png png2map
	./png2map level7_map.png level7_map.inc

###

level8_map.zx02:	level8_map.inc
	$(ZX02) level8_map.inc level8_map.zx02

level8_map.inc:	level8_map.png png2map
	./png2map level8_map.png level8_map.inc

###

level9_map.zx02:	level9_map.inc
	$(ZX02) level9_map.inc level9_map.zx02

level9_map.inc:	level9_map.png png2map
	./png2map level9_map.png level9_map.inc

###

level10_map.zx02:	level10_map.inc
	$(ZX02) level10_map.inc level10_map.zx02

level10_map.inc:	level10_map.png png2map
	./png2map level10_map.png level10_map.inc

###

level11_map.zx02:	level11_map.inc
	$(ZX02) level11_map.inc level11_map.zx02

level11_map.inc:	level11_map.png png2map
	./png2map level11_map.png level11_map.inc

###

level12_map.zx02:	level12_map.inc
	$(ZX02) level12_map.inc level12_map.zx02

level12_map.inc:	level12_map.png png2map
	./png2map level12_map.png level12_map.inc

###

level13_map.zx02:	level13_map.inc
	$(ZX02) level13_map.inc level13_map.zx02

level13_map.inc:	level13_map.png png2map
	./png2map level13_map.png level13_map.inc

###

level14_map.zx02:	level14_map.inc
	$(ZX02) level14_map.inc level14_map.zx02

level14_map.inc:	level14_map.png png2map
	./png2map level14_map.png level14_map.inc

###

level15_map.zx02:	level15_map.inc
	$(ZX02) level15_map.inc level15_map.zx02

level15_map.inc:	level15_map.png png2map
	./png2map level15_map.png level15_map.inc

###

level16_map.zx02:	level16_map.inc
	$(ZX02) level16_map.inc level16_map.zx02

level16_map.inc:	level16_map.png png2map
	./png2map level16_map.png level16_map.inc


###

mars_map.zx02:	mars_map.inc
	$(ZX02) mars_map.inc mars_map.zx02

mars_map.inc:	mars_map.png png2map
	./png2map mars_map.png mars_map.inc


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
