include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	outer_door.inc

#####

outer_door.inc:	$(PNG2RLE) outer_door.png
	$(PNG2RLE) asm outer_door.png outer_door_rle > outer_door.inc



#####

clean:		
		rm -f *~ *.inc
