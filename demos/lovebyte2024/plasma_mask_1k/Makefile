include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasma_mask.dsk

plasma_mask.dsk:	HELLO PLASMA_MASK
	cp $(EMPTYDISK) plasma_mask.dsk
	$(DOS33) -y plasma_mask.dsk SAVE A HELLO
	$(DOS33) -y plasma_mask.dsk BSAVE -a 0x4000 PLASMA_MASK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA_MASK:	plasma_mask.o
	ld65 -o PLASMA_MASK plasma_mask.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasma_mask.o:	plasma_mask.s gr_gbascalc.s make_tables.s \
	graphics/dsr_big.gr.zx02
	ca65 -o plasma_mask.o plasma_mask.s -l plasma_mask.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO PLASMA_MASK
