include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	plasma.dsk

plasma.dsk:	HELLO PLASMA PLASMA_TINY
	cp empty.dsk plasma.dsk
	$(DOS33) -y plasma.dsk SAVE A HELLO
	$(DOS33) -y plasma.dsk BSAVE -a 0xC00 PLASMA
	$(DOS33) -y plasma.dsk BSAVE -a 0xC00 PLASMA_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKERSCRIPTS)/apple2_c00.inc

plasma.o:	plasma.s
	ca65 -o plasma.o plasma.s -l plasma.lst

###

PLASMA_TINY:	plasma_tiny.o
	ld65 -o PLASMA_TINY plasma_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

plasma_tiny.o:	plasma_tiny.s
	ca65 -o plasma_tiny.o plasma_tiny.s -l plasma_tiny.lst


###

clean:	
	rm -f *~ *.o *.lst PLASMA
