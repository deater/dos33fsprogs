include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	boxes.dsk make_boxes

boxes.dsk:	HELLO A2_BOXES BOXES
	cp $(EMPTYDISK) boxes.dsk
	$(DOS33) -y boxes.dsk SAVE A HELLO
	$(DOS33) -y boxes.dsk BSAVE -a 0x300 BOXES
	$(DOS33) -y boxes.dsk BSAVE -a 0xC00 A2_BOXES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

A2_BOXES:	a2_boxes.o
	ld65 -o A2_BOXES a2_boxes.o -C $(LINKERSCRIPTS)/apple2_c00.inc

a2_boxes.o:	a2_boxes.s
	ca65 -o a2_boxes.o a2_boxes.s -l a2_boxes.lst

###

BOXES:	boxes.o
	ld65 -o BOXES boxes.o -C $(LINKERSCRIPTS)/apple2_300.inc

boxes.o:	boxes.s
	ca65 -o boxes.o boxes.s -l boxes.lst


###

make_boxes:	make_boxes.o
	$(CC) -o make_boxes make_boxes.o $(LFLAGS)

make_boxes.o:	make_boxes.c
	$(CC) $(CFLAGS) -c make_boxes.c

###

clean:	
	rm -f *~ *.o *.lst HELLO A2_BOXES BOXES make_boxes
