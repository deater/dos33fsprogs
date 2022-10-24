include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	moon.dsk

moon.dsk:	HELLO MOON MOON2
	cp $(EMPTY_DISK) moon.dsk
	$(DOS33) -y moon.dsk SAVE A HELLO
	$(DOS33) -y moon.dsk BSAVE -a 0xc00 MOON
	$(DOS33) -y moon.dsk BSAVE -a 0xc00 MOON2

###

MOON: moon.o
	ld65 -o MOON moon.o -C $(LINKER_DIR)/apple2_c00.inc

moon.o:	moon.s
	ca65 -o moon.o moon.s -l moon.lst

###

MOON2: moon2.o
	ld65 -o MOON2 moon2.o -C $(LINKER_DIR)/apple2_c00.inc

moon2.o:	moon2.s
	ca65 -o moon2.o moon2.s -l moon2.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO MOON MOON2
