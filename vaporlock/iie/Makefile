include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	split.dsk

split.dsk:	HELLO SPLIT NOVBLANK DOUBLE
	cp $(EMPTYDISK) split.dsk
	$(DOS33) -y split.dsk SAVE A HELLO
	$(DOS33) -y split.dsk BSAVE -a 0x384 SPLIT
	$(DOS33) -y split.dsk BSAVE -a 0x1000 DOUBLE
	$(DOS33) -y split.dsk BSAVE -a 0x384 NOVBLANK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DOUBLE:	double.o
	ld65 -o DOUBLE double.o -C $(LINKERSCRIPTS)/apple2_1000.inc

double.o:	double.s
	ca65 -o double.o double.s -l double.lst

###

SPLIT:	split.o
	ld65 -o SPLIT split.o -C $(LINKERSCRIPTS)/apple2_384.inc

split.o:	split.s
	ca65 -o split.o split.s -l split.lst

###

NOVBLANK:	novblank.o
	ld65 -o NOVBLANK novblank.o -C $(LINKERSCRIPTS)/apple2_384.inc

novblank.o:	novblank.s
	ca65 -o novblank.o novblank.s -l novblank.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO SPLIT NOVBLANK
