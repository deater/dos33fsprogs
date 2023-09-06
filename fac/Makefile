include ../Makefile.inc

DOS33 = ../utils/dos33fs-utils/dos33
TOKENIZE = ../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../linker_scripts
EMPTYDISK = ../empty_disk/empty.dsk

all:	fac.dsk

fac.dsk:	HELLO SIN3
	cp $(EMPTYDISK) fac.dsk
	$(DOS33) -y fac.dsk SAVE A HELLO
	$(DOS33) -y fac.dsk BSAVE -a 0xC00 SIN3


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SIN3:	sin3.o
	ld65 -o SIN3 sin3.o -C $(LINKERSCRIPTS)/apple2_c00.inc

sin3.o:	sin3.s
	ca65 -o sin3.o sin3.s -l sin3.lst

###

clean:	
	rm -f *~ *.o *.lst SIN3 HELLO
