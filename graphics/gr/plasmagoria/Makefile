include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasmag.dsk

plasmag.dsk:	HELLO PLASMAG PLASMAG_FULL PLASMAG_TINY
	cp $(EMPTYDISK) plasmag.dsk
	$(DOS33) -y plasmag.dsk SAVE A HELLO
	$(DOS33) -y plasmag.dsk BSAVE -a 0x4000 PLASMAG
	$(DOS33) -y plasmag.dsk BSAVE -a 0x4000 PLASMAG_FULL
	$(DOS33) -y plasmag.dsk BSAVE -a 0x4000 PLASMAG_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMAG:	plasmag.o
	ld65 -o PLASMAG plasmag.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasmag.o:	plasmag.s
	ca65 -o plasmag.o plasmag.s -l plasmag.lst

###

PLASMAG_TINY:	plasmag_tiny.o
	ld65 -o PLASMAG_TINY plasmag_tiny.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasmag_tiny.o:	plasmag_tiny.s gr_gbascalc.s make_tables.s
	ca65 -o plasmag_tiny.o plasmag_tiny.s -l plasmag_tiny.lst

###

PLASMAG_FULL:	plasmag_full.o
	ld65 -o PLASMAG_FULL plasmag_full.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasmag_full.o:	plasmag_full.s
	ca65 -o plasmag_full.o plasmag_full.s -l plasmag_full.lst


###

clean:	
	rm -f *~ *.o *.lst PLASMAG HELLO
