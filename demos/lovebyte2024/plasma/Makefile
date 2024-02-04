include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasmag.dsk

plasmag.dsk:	HELLO PLASMAG_TINY
	cp $(EMPTYDISK) plasmag.dsk
	$(DOS33) -y plasmag.dsk SAVE A HELLO
	$(DOS33) -y plasmag.dsk BSAVE -a 0x4000 PLASMAG_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMAG_TINY:	plasmag_tiny.o
	ld65 -o PLASMAG_TINY plasmag_tiny.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasmag_tiny.o:	plasmag_tiny.s gr_gbascalc.s make_tables.s
	ca65 -o plasmag_tiny.o plasmag_tiny.s -l plasmag_tiny.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO PLASMAG_TINY
