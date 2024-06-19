include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts/
EMPTY = ../../empty_disk/


all:	numbers.dsk

numbers.dsk:	HELLO NUMBERS PLASMA
	cp $(EMPTY)/empty.dsk numbers.dsk
	$(DOS33) -y numbers.dsk SAVE A HELLO
	$(DOS33) -y numbers.dsk BSAVE -a 0x2000 NUMBERS
	$(DOS33) -y numbers.dsk BSAVE -a 0x4000 PLASMA

###

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasma.o:	plasma.s \
	zp.inc hardware.inc
	ca65 -o plasma.o plasma.s -l plasma.lst


####

NUMBERS:	numbers.o
	ld65 -o NUMBERS numbers.o -C $(LINKERSCRIPTS)/apple2_2000.inc

numbers.o:	numbers.s \
	print_dni_numbers.s \
	zp.inc hardware.inc number_sprites.inc
	ca65 -o numbers.o numbers.s -l numbers.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:		
		rm -f *~ *.o *.lst NUMBERS
