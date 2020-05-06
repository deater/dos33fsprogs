include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	autumn.dsk

autumn.dsk:	HELLO AUTUMN
	cp empty.dsk autumn.dsk
	$(DOS33) -y autumn.dsk SAVE A HELLO
	$(DOS33) -y autumn.dsk BSAVE -a 0x1000 AUTUMN


AUTUMN: autumn.o
	ld65 -o AUTUMN autumn.o -C ../linker_scripts/apple2_1000.inc

autumn.o:	autumn.s
	ca65 -o autumn.o autumn.s -l autumn.lst

###


HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO AUTUMN


