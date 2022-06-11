include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	transition.dsk

transition.dsk:	HELLO RECTANGLE BARS FOLD OOZE32
	cp $(EMPTYDISK) transition.dsk
	$(DOS33) -y transition.dsk SAVE A HELLO
	$(DOS33) -y transition.dsk BSAVE -a 0x3f5 RECTANGLE
	$(DOS33) -y transition.dsk BSAVE -a 0xc00 BARS
	$(DOS33) -y transition.dsk BSAVE -a 0xc00 FOLD
	$(DOS33) -y transition.dsk BSAVE -a 0xef5 OOZE32

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

FOLD:	fold.o
	ld65 -o FOLD fold.o -C $(LINKERSCRIPTS)/apple2_c00.inc

fold.o:	fold.s
	ca65 -o fold.o fold.s -l fold.lst

###

OOZE32:	ooze32.o
	ld65 -o OOZE32 ooze32.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

ooze32.o:	ooze32.s
	ca65 -o ooze32.o ooze32.s -l ooze32.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO RECTANGLE BARS FOLD OOZE32

