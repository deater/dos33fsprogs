include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	entropy.dsk

entropy.dsk:	ENTROPY ENTROPY.BAS
	$(DOS33) -y entropy.dsk BSAVE -a 0x0C00 ENTROPY
	$(DOS33) -y entropy.dsk SAVE A ENTROPY.BAS

###

ENTROPY:	entropy.o
	ld65 -o ENTROPY entropy.o -C ../../linker_scripts/apple2_c00.inc

entropy.o:	entropy.s
	ca65 -o entropy.o entropy.s -l entropy.lst

####

ENTROPY.BAS:	entropy.bas
	$(TOKENIZE) < entropy.bas > ENTROPY.BAS

####

clean:	
	rm -f *~ *.o *.lst ENTROPY ENTROPY.BAS
