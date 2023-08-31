include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasmag.dsk

plasmag.dsk:	HELLO PLASMAG
	cp $(EMPTYDISK) plasmag.dsk
	$(DOS33) -y plasmag.dsk SAVE A HELLO
	$(DOS33) -y plasmag.dsk BSAVE -a 0x4000 PLASMAG

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMAG:	plasmag.o
	ld65 -o PLASMAG plasmag.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasmag.o:	plasmag.s
	ca65 -o plasmag.o plasmag.s -l plasmag.lst

###

clean:	
	rm -f *~ *.o *.lst PLASMAG HELLO
