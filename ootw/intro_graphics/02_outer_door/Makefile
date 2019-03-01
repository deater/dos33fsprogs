include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	outer_door.inc feet.inc

#####

outer_door.inc:	$(PNG2RLE) outer_door.png
	$(PNG2RLE) asm outer_door.png outer_door_rle > outer_door.inc

feet.inc:	$(PNG2RLE) feet01.png feet02.png \
		feet03.png feet04.png feet05.png feet06.png \
		feet07.png feet08.png feet09.png feet10.png \
		feet11.png feet12.png feet13.png feet14.png \
		feet15.png blank.png
	$(PNG2RLE) asm feet01.png feet01_rle > feet.inc
	$(PNG2RLE) asm feet02.png feet02_rle >> feet.inc
	$(PNG2RLE) asm feet03.png feet03_rle >> feet.inc
	$(PNG2RLE) asm feet04.png feet04_rle >> feet.inc
	$(PNG2RLE) asm feet05.png feet05_rle >> feet.inc
	$(PNG2RLE) asm feet06.png feet06_rle >> feet.inc
	$(PNG2RLE) asm feet07.png feet07_rle >> feet.inc
	$(PNG2RLE) asm feet08.png feet08_rle >> feet.inc
	$(PNG2RLE) asm feet09.png feet09_rle >> feet.inc
	$(PNG2RLE) asm feet10.png feet10_rle >> feet.inc
	$(PNG2RLE) asm feet11.png feet11_rle >> feet.inc
	$(PNG2RLE) asm feet12.png feet12_rle >> feet.inc
	$(PNG2RLE) asm feet13.png feet13_rle >> feet.inc
	$(PNG2RLE) asm feet14.png feet14_rle >> feet.inc
	$(PNG2RLE) asm feet15.png feet15_rle >> feet.inc




#####

clean:		
		rm -f *~ *.inc
