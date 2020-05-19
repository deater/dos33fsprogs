include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	seasons.dsk

seasons.dsk:	HELLO SEASONS
	cp empty.dsk seasons.dsk
	$(DOS33) -y seasons.dsk SAVE A HELLO
	$(DOS33) -y seasons.dsk BSAVE -a 0x50 SEASONS


SEASONS: seasons.o
#	ld65 -o SEASONS seasons.o -C ../linker_scripts/apple2_1000.inc
	ld65 -o SEASONS seasons.o -C ../linker_scripts/apple2_50_zp.inc

seasons.o:	seasons.s
	ca65 -o seasons.o seasons.s -l seasons.lst

###


HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO SEASONS


