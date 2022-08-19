include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	solaris.dsk

solaris.dsk:	HELLO SOLARIS
	cp $(EMPTYDISK) solaris.dsk
	$(DOS33) -y solaris.dsk SAVE A HELLO
	$(DOS33) -y solaris.dsk BSAVE -a 0xc00 SOLARIS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


SOLARIS:	solaris.o
	ld65 -o SOLARIS solaris.o -C $(LINKERSCRIPTS)/apple2_c00.inc

solaris.o:	solaris.s
	ca65 -o solaris.o solaris.s -l solaris.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SOLARIS

