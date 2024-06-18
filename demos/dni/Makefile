include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY = ../../empty_disk/


all:	numbers.dsk

numbers.dsk:	HELLO NUMBERS
	cp $(EMPTY)/empty.dsk numbers.dsk
	$(DOS33) -y numbers.dsk SAVE A HELLO
	$(DOS33) -y numbers.dsk BSAVE -a 0x2000 NUMBERS


####

NUMBERS:	numbers.o
	ld65 -o NUMBERS numbers.o -C ../../linker_scripts/apple2_2000.inc

numbers.o:	numbers.s \
	zp.inc hardware.inc number_sprites.inc
	ca65 -o numbers.o numbers.s -l numbers.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:		
		rm -f *~ *.o *.lst NUMBERS
