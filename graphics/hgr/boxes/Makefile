include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	boxes.dsk make_boxes

boxes.dsk:	HELLO MYST.BAS MYST_TINY.BAS
	cp $(EMPTYDISK) boxes.dsk
	$(DOS33) -y boxes.dsk SAVE A HELLO
	$(DOS33) -y boxes.dsk SAVE A MYST.BAS
	$(DOS33) -y boxes.dsk SAVE A MYST_TINY.BAS
#	$(DOS33) -y boxes.dsk BSAVE -a 0x300 BOXES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MYST.BAS:	myst.bas
	$(TOKENIZE) < myst.bas > MYST.BAS

###

MYST_TINY.BAS:	myst_tiny.bas
	$(TOKENIZE) < myst_tiny.bas > MYST_TINY.BAS


###

make_boxes:	make_boxes.o
	$(CC) -o make_boxes make_boxes.o $(LFLAGS)

make_boxes.o:	make_boxes.c
	$(CC) $(CFLAGS) -c make_boxes.c

###

clean:	
	rm -f *~ *.o *.lst MYST.BAS MYST_TINY.BAS make_boxes
