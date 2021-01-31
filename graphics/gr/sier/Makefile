include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	sier.dsk

sier.dsk:	HELLO SIER SIER_TINY
	cp empty.dsk sier.dsk
	$(DOS33) -y sier.dsk SAVE A HELLO
	$(DOS33) -y sier.dsk BSAVE -a 0x36C SIER
	$(DOS33) -y sier.dsk BSAVE -a 0x300 SIER_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SIER:	sier.o
	ld65 -o SIER sier.o -C ./apple2_36c.inc

sier.o:	sier.s
	ca65 -o sier.o sier.s -l sier.lst

###

SIER_TINY:	sier_tiny.o
	ld65 -o SIER_TINY sier_tiny.o -C $(LINKERSCRIPTS)/apple2_300.inc

sier_tiny.o:	sier_tiny.s
	ca65 -o sier_tiny.o sier_tiny.s -l sier_tiny.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO SIER SIER_TINY
