include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	drops.dsk

drops.dsk:	HELLO DROPS DROPS_TINY
	cp empty.dsk drops.dsk
	$(DOS33) -y drops.dsk SAVE A HELLO
	$(DOS33) -y drops.dsk BSAVE -a 0x300 DROPS
	$(DOS33) -y drops.dsk BSAVE -a 0x300 DROPS_TINY


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DROPS:	drops.o
	ld65 -o DROPS drops.o -C $(LINKERSCRIPTS)/apple2_300.inc

drops.o:	drops.s
	ca65 -o drops.o drops.s -l drops.lst

###

DROPS_TINY:	drops_tiny.o
	ld65 -o DROPS_TINY drops_tiny.o -C $(LINKERSCRIPTS)/apple2_300.inc

drops_tiny.o:	drops_tiny.s
	ca65 -o drops_tiny.o drops_tiny.s -l drops_tiny.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO DROPS DROPS_TINY
