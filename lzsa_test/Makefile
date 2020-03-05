include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	gr_lzsa.dsk

gr_lzsa.dsk:	HELLO GR_LZSA
	cp empty.dsk mist.dsk
	$(DOS33) -y mist.dsk SAVE A HELLO
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 GR_LZSA

###

GR_LZSA: gr_lzsa.o
	ld65 -o GR_LZSA gr_lzsa.o -C ../linker_scripts/apple2_1000.inc

gr_lzsa.o:	gr_lzsa.s decompress_small_v2.s
	ca65 -o gr_lzsa.o gr_lzsa.s -l gr_lzsa.lst


###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:		
		rm -f *~ *.o *.lst HELLO GR_LZSA
