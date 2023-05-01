include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	double.dsk

double.dsk:	HELLO DOUBLE
	cp $(EMPTYDISK) double.dsk
	$(DOS33) -y double.dsk SAVE A HELLO
	$(DOS33) -y double.dsk BSAVE -a 0x1000 DOUBLE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DOUBLE:	double.o
	ld65 -o DOUBLE double.o -C $(LINKERSCRIPTS)/apple2_1000.inc

double.o:	double.s \
	zp.inc
	ca65 -o double.o double.s -l double.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO DOUBLE
