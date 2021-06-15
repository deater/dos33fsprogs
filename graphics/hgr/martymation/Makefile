include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	marty.dsk

marty.dsk:	HELLO MARTY
	cp $(EMPTY_DISK)/empty.dsk marty.dsk
	$(DOS33) -y marty.dsk SAVE A HELLO
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 MARTY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MARTY:	marty.o
	ld65 -o MARTY marty.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

marty.o:	marty.s
	ca65 -o marty.o marty.s -l marty.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO MARTY
