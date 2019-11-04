include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	starbase.inc

#####

starbase.inc:	$(PNG2RLE) \
	jail.png hallway.png window.png ship.png
	$(PNG2RLE) asm jail.png jail_rle > starbase.inc
	$(PNG2RLE) asm hallway.png hallway_rle >> starbase.inc
	$(PNG2RLE) asm window.png window_rle >> starbase.inc
	$(PNG2RLE) asm ship.png ship_rle >> starbase.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

