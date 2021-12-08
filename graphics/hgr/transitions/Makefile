include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	transition.dsk

transition.dsk:	HELLO RECTANGLE BARS
	cp $(EMPTYDISK) transition.dsk
	$(DOS33) -y transition.dsk SAVE A HELLO
	$(DOS33) -y transition.dsk BSAVE -a 0x3f5 RECTANGLE
	$(DOS33) -y transition.dsk BSAVE -a 0xc00 BARS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RECTANGLE:	rectangle.o
	ld65 -o RECTANGLE rectangle.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

rectangle.o:	rectangle.s
	ca65 -o rectangle.o rectangle.s -l rectangle.lst

###

BARS:	bars.o
	ld65 -o BARS bars.o -C $(LINKERSCRIPTS)/apple2_c00.inc

bars.o:	bars.s
	ca65 -o bars.o bars.s -l bars.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO RECTANGLE BARS

