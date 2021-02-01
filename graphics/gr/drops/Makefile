include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	drops.dsk

drops.dsk:	HELLO DROPS
	cp empty.dsk drops.dsk
	$(DOS33) -y drops.dsk SAVE A HELLO
	$(DOS33) -y drops.dsk BSAVE -a 0x300 DROPS


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DROPS:	drops.o
	ld65 -o DROPS drops.o -C $(LINKERSCRIPTS)/apple2_300.inc

drops.o:	drops.s
	ca65 -o drops.o drops.s -l drops.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO DROPS
