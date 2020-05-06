include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	polly.dsk

polly.dsk:	HELLO POLLY
	cp empty.dsk polly.dsk
	$(DOS33) -y polly.dsk SAVE A HELLO
	$(DOS33) -y polly.dsk BSAVE -a 0x1000 POLLY


POLLY: polly.o
	ld65 -o POLLY polly.o -C ../linker_scripts/apple2_1000.inc

polly.o:	polly.s
	ca65 -o polly.o polly.s -l polly.lst

###


HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO POLLY


