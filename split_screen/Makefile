include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	split.dsk

split.dsk:	BISHOP BISHOP.BAS RAINBOW.BAS
	$(DOS33) -y split.dsk BSAVE -a 0x0300 BISHOP
	$(DOS33) -y split.dsk SAVE A BISHOP.BAS
	$(DOS33) -y split.dsk SAVE A RAINBOW.BAS

BISHOP:	bishop.o
	ld65 -o BISHOP bishop.o -C ../linker_scripts/apple2_300.inc

bishop.o:	bishop.s
	ca65 -o bishop.o bishop.s -l bishop.lst

BISHOP.BAS:	bishop.bas
	$(TOKENIZE) < bishop.bas > BISHOP.BAS

RAINBOW.BAS:	rainbow.bas
	$(TOKENIZE) < rainbow.bas > RAINBOW.BAS

clean:	
	rm -f *~ *.o *.lst BISHOP
