include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	textscroll.dsk

textscroll.dsk:	HELLO MOVE
	cp $(EMPTYDISK) textscroll.dsk
	$(DOS33) -y textscroll.dsk SAVE A HELLO
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 MOVE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MOVE: move.o
	ld65 -o MOVE move.o -C $(LINKERSCRIPTS)/apple2_c00.inc

move.o:       move.s
	ca65 -o move.o move.s -l move.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO MOVE
