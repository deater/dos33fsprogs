include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	dark.dsk

dark.dsk:	HELLO DARK
	cp $(EMPTY_DISK) dark.dsk
	$(DOS33) -y dark.dsk SAVE A HELLO
	$(DOS33) -y dark.dsk BSAVE -a 0x1000 DARK


###

DARK: dark.o
	ld65 -o DARK dark.o -C ../../linker_scripts/apple2_1000.inc

dark.o:	dark.s
	ca65 -o dark.o dark.s -l dark.lst

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO DARK

