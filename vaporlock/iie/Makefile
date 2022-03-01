include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	split.dsk

split.dsk:	HELLO SPLIT NOTWORK
	cp $(EMPTYDISK) split.dsk
	$(DOS33) -y split.dsk SAVE A HELLO
	$(DOS33) -y split.dsk BSAVE -a 0x384 SPLIT
	$(DOS33) -y split.dsk BSAVE -a 0x384 NOTWORK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SPLIT:	split.o
	ld65 -o SPLIT split.o -C $(LINKERSCRIPTS)/apple2_384.inc

split.o:	split.s
	ca65 -o split.o split.s -l split.lst

###

NOTWORK:	notwork.o
	ld65 -o NOTWORK notwork.o -C $(LINKERSCRIPTS)/apple2_384.inc

notwork.o:	notwork.s
	ca65 -o notwork.o notwork.s -l notwork.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO SPLIT NOTWORK
