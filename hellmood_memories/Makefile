include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	memories.dsk

memories.dsk:	HELLO CIRCLES.BAS CIRCLES
	cp empty.dsk memories.dsk
	$(DOS33) -y memories.dsk SAVE A HELLO
	$(DOS33) -y memories.dsk SAVE A CIRCLES.BAS
	$(DOS33) -y memories.dsk BSAVE -a 0x070 CIRCLES


CIRCLES: circles.o
	ld65 -o CIRCLES circles.o -C ../linker_scripts/apple2_70_zp.inc

circles.o:	circles.s
	ca65 -o circles.o circles.s -l circles.lst

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

CIRCLES.BAS:	zooming_circles.bas
	../asoft_basic-utils/tokenize_asoft < zooming_circles.bas > CIRCLES.BAS

####


clean:		
		rm -f *~ *.o *.lst HELLO CIRCLES.BAS

