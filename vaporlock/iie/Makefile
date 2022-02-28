include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	split.dsk

split.dsk:	HELLO SPLIT
	cp $(EMPTYDISK) split.dsk
	$(DOS33) -y split.dsk SAVE A HELLO
	$(DOS33) -y split.dsk BSAVE -a 0x384 SPLIT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SPLIT:	split.o
	ld65 -o SPLIT split.o -C $(LINKERSCRIPTS)/apple2_384.inc

split.o:	split.s
	ca65 -o split.o split.s -l split.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SPLIT
