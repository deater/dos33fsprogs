include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	wires.dsk

wires.dsk:	HELLO WIRES BLUEORANGE BLUEORANGEZ
	cp $(EMPTY_DISK)/empty.dsk wires.dsk
	$(DOS33) -y wires.dsk SAVE A HELLO
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 WIRES
	$(DOS33) -y wires.dsk BSAVE -a 0x0373 BLUEORANGE
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 BLUEORANGEZ

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

WIRES:	wires.o
	ld65 -o WIRES wires.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

wires.o:	wires.s
	ca65 -o wires.o wires.s -l wires.lst

####

BLUEORANGE:	blueorange.o
	ld65 -o BLUEORANGE blueorange.o -C $(LINKER_SCRIPTS)/apple2_373.inc

blueorange.o:	blueorange.s
	ca65 -o blueorange.o blueorange.s -l blueorange.lst

####

BLUEORANGEZ:	blueorange.o
	ld65 -o BLUEORANGEZ blueorange.o -C $(LINKER_SCRIPTS)/apple2_c00.inc


######

clean:	
	rm -f *~ *.o *.lst WIRES
